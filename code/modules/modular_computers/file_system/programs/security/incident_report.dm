/datum/computer_file/program/incident_report
	filename = "incidentreport"
	filedesc = "IH Incident Reporting Tool"
	nanomodule_path = /datum/nano_module/program/incident_report
	program_icon_state = "warrant"
	program_key_state = "security_key"
	program_menu_icon = "star"
	extended_desc = "Ironhammer tool for tracking incidents on-board the CEV Eris."
	size = 8
	available_on_ntnet = FALSE
	requires_ntnet = TRUE

	var/list/incident_log = list()    // Make this part of a larger IH crime handling system
	var/list/known_offender = list()

	var/selected_offender
	var/current_log_page = 1
	var/log_page_max

/datum/computer_file/program/incident_report/Topic(href, href_list)
	. = ..()
	if(.)
		return
	
	// Reports
	// Create report
	// Edit report

	if(href_list["PRG_print"])
		var/log_id = href_list["PRG_print"]
		if(computer?.printer)
			var/list/log_data = LAZYACCESS(incident_log, log_id)

			if(!LAZYLEN(log_data))
				to_chat(usr, SPAN_WARNING("Unable to print report: no report with ID \"[log_id]\" found."))
				return

			var/title
			title = "incident report - #[log_id]"

			var/text
			text += "<h3>Incident Report - #[log_id]</h3>"
			text += "<hr><font size = \"2\">"
			text += "Offender: [log_data["offender"]]<br>"
			text += "Sentence: [log_data["sentence"]]<br>"
			text += "Incident Summary:<br>"
			text += "<ul>"
			text += log_data["summary"]
			text += "</ul>"
			text += "Charges: [log_data["charges"]]<br>"
			text += "Witnesses: [log_data["witnesses"]]<br>"
			text += "Evidence: [log_data["evidence"]]<br>"

			computer.printer.print_text(text, title)
		else
			to_chat(usr, SPAN_WARNING("Unable to print report: no printer component installed."))
		return TRUE


	// Page navigation
	if(href_list["PRG_page_first"])
		current_log_page = 1
		return TRUE

	if(href_list["PRG_page_prev_10"])
		current_log_page = max(1, current_log_page - 10)
		return TRUE

	if(href_list["PRG_page_prev"])
		current_log_page = max(1, --current_log_page)
		return TRUE

	if(href_list["PRG_page_select"])
		var/input = input("Enter page number (1-[log_page_max])", "Page Selection") as num|null
		if(!input)
			return
		current_log_page = clamp(input, 1, log_page_max)
		return TRUE

	if(href_list["PRG_page_next"])
		current_log_page = min(log_page_max, ++current_log_page)
		return TRUE

	if(href_list["PRG_page_next_10"])
		current_log_page = min(log_page_max, current_log_page + 10)
		return TRUE

	if(href_list["PRG_page_last"])
		current_log_page = log_page_max
		return TRUE

/datum/nano_module/program/incident_report
	name = "IH Incident Reporting Tool"

/datum/nano_module/program/incident_report/nano_ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = NANOUI_FOCUS, state = GLOB.default_state)
	var/list/data = nano_ui_data()

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "incident_report.tmpl", name, 910, 800, state = state)
		ui.set_auto_update(1)
		ui.set_initial_data(data)
		ui.open()

/datum/nano_module/program/trade/nano_ui_data()
	. = ..()
	var/datum/computer_file/program/trade/PRG = program
	if(!istype(PRG))
		return
	
	var/list/current_log = incident_log

	if(selected_offender)
		var/list/sanitized_log = list()
		for(var/log_entry in current_log)
			var/list/log_data = log_entry
			if(log_data["offender"] == selected_offender)
				sanitized_log |= list(log_data)
		current_log = sanitized_log

	var/logs_per_page = 10
	var/logs_to_display = logs_per_page
	PRG.log_page_max = round(current_log.len / logs_per_page, 1)
	var/page_remainder = current_log.len % logs_per_page
	if(current_log.len < logs_per_page * PRG.current_log_page)
		logs_to_display = page_remainder
	if(page_remainder < logs_per_page / 2)
		++PRG.log_page_max

	.["page_max"] = PRG.log_page_max ? PRG.log_page_max : 1

	var/list/page_of_logs = list()

	if(logs_to_display)
		for(var/i in 1 to logs_to_display)
			page_of_logs += list(current_log[i + (logs_per_page * (PRG.current_log_page - 1))])

	.["current_log_data"] = page_of_logs
