// lib/data/api/api_endpoints.dart
//
// Converted from apiSlice.js (RTK Query) → Flutter constants
// All endpoint paths are grouped by service domain.

import '../../core/constants/environment.dart';

class ApiEndpoints {
  ApiEndpoints._(); // prevent instantiation

  // ─────────────────────────────────────────
  // USER SERVICE  (port 1000)
  // ─────────────────────────────────────────
  static String get login => '${Environment.userServiceUrl}/usrserv/auth_token';

  static String get userModules =>
      '${Environment.userServiceUrl}/usrserv/user_modules';

  static String get logout => '${Environment.userServiceUrl}/usrserv/logout';

  static String get getCaptcha =>
      '${Environment.userServiceUrl}/usrserv/generate_captcha';

  static String get getEntity =>
      '${Environment.userServiceUrl}/usrserv/get_entity';

  static String get pushNotification =>
      '${Environment.userServiceUrl}/usrserv/pushnotification';

  /// query params: query, page
  static String searchEmployee({required String query, required int page}) =>
      '${Environment.userServiceUrl}/usrserv/searchemployee?query=$query&page=$page';

  static String employeeDetailsUpdate(int empId) =>
      '${Environment.userServiceUrl}/usrserv/employee/$empId';

  static String get approvalRole =>
      '${Environment.userServiceUrl}/usrserv/employee_approvalrole';

  static String get taskDuration =>
      '${Environment.userServiceUrl}/usrserv/sum_of_duration?action=android';

  static String employeeInfo(int empId) =>
      '${Environment.userServiceUrl}/usrserv/employeeinfo_get/$empId';

  /// query params: query, page
  static String branchList({required String name, required int page}) =>
      '${Environment.userServiceUrl}/usrserv/search_employeebranch?query=$name&page=$page';

  static String departmentDetailGet(int empId) =>
      '${Environment.userServiceUrl}/usrserv/department_details/$empId';

  static String get forgotPassword =>
      '${Environment.userServiceUrl}/usrserv/forgetpassword';

  static String branchSearch({
    String searchText = '',
    int pageNo = 1,
    String display = 'CS',
  }) =>
      '${Environment.userServiceUrl}/usrserv/search_branch?query=$searchText&page=$pageNo&display=$display';

  static String branchDropdown(Map<String, dynamic> params) {
    final q = Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v')));
    return '${Environment.userServiceUrl}/usrserv/search_branch${q.query.isNotEmpty ? '?${q.query}' : ''}';
  }

  static String storageLocation(Map<String, dynamic> params) {
    final q = Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v')));
    return '${Environment.userServiceUrl}/usrserv/fetch_storage_location?${q.query}';
  }

  static String empBranch(int empId) =>
      '${Environment.userServiceUrl}/usrserv/emp_empbranch/$empId';

  static String get getEmployeeBranch =>
      '${Environment.userServiceUrl}/usrserv/search_employeebranch';

  static String getInventoryProject(Map<String, dynamic> params) {
    final q = Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v')));
    return '${Environment.userServiceUrl}/usrserv/get_pbt_branch?${q.query}';
  }

  // ─────────────────────────────────────────
  // CRM SERVICE  (port 1010)
  // ─────────────────────────────────────────
  static String agentReport(String agentId) =>
      '${Environment.crmServiceUrl}/reportserv/agent_report?agent_id=$agentId';

  static String customerReport(String customerId) =>
      '${Environment.crmServiceUrl}/reportserv/customer_report?customer_id=$customerId';

  static String get saveLocation =>
      '${Environment.crmServiceUrl}/newprodserv/track_agent';

  static String get getSavedLocation =>
      '${Environment.crmServiceUrl}/newprodserv/track_agent';

  /// POST  – body: {page_size:10, page:pageNo}
  static String getCustomers(int pageNo) =>
      '${Environment.crmServiceUrl}/newprodserv/mytask?page_size=10&page=$pageNo';

  static String getCustomersForSite(int pageNo) =>
      '${Environment.crmServiceUrl}/newprodserv/mytask?page_size=10&page=$pageNo';

  static String getNotes({String? action}) =>
      '${Environment.crmServiceUrl}/newprodserv/user_notes?type=1${action != null ? '&action=$action' : ''}';

  static String attachmentSummary(String refId) =>
      '${Environment.crmServiceUrl}/custserv/attachement?ref_type=1&ref_id=$refId';

  static String get attachmentCreation =>
      '${Environment.crmServiceUrl}/custserv/attachement';

  static String timelineSummary(String code) =>
      '${Environment.crmServiceUrl}/newprodserv/timeline?type=1&code=$code';

  static String getLoans(int pageNo) =>
      '${Environment.crmServiceUrl}/newprodserv/module_task?page=$pageNo';

  static String customerInfo(String id, String type) =>
      '${Environment.crmServiceUrl}/newprodserv/fetch_modulewise/$id?type=$type';

  static String updateCustomerInfo(String type) =>
      '${Environment.crmServiceUrl}/custserv/module_config?action=update&type=$type';

  static String getModuleStatus(String taskMapId, String action) =>
      '${Environment.crmServiceUrl}/newprodserv/module_status_change?task_map_id=$taskMapId&action=$action';

  static String get getLoanDetails =>
      '${Environment.crmServiceUrl}/newprodserv/task_summary';

  static String get paymentAction =>
      '${Environment.crmServiceUrl}/newprodserv/task_status_update';

  static String qrGenerator(String id, String amount) =>
      '${Environment.crmServiceUrl}/newprodserv/url_generate?id=$id&amount=$amount';

  static String qrTransactionStatus(String id) =>
      '${Environment.crmServiceUrl}/newprodserv/taskmapping_id_get?id=$id';

  static String siteVisitAssign({
    String? assignId,
    int? visitStatus,
    String? fromDate,
    String? toDate,
  }) {
    final params = <String, String>{};
    if (assignId != null) params['assign_id'] = assignId;
    if (visitStatus != null) params['visit_status'] = '$visitStatus';
    if (fromDate != null) params['from_date'] = fromDate;
    if (toDate != null) params['to_date'] = toDate;
    final q = Uri(queryParameters: params).query;
    return '${Environment.crmServiceUrl}/newprodserv/sitevisit_assign${q.isNotEmpty ? '?$q' : ''}';
  }

  static String siteVisitDropDown({int page = 1}) =>
      '${Environment.crmServiceUrl}/newprodserv/common_drop_down?page=$page&action=sitevisit';

  static String get siteVisitCreation =>
      '${Environment.crmServiceUrl}/newprodserv/sitevisit_create';

  static String siteVisitCreationSummary(int page) =>
      '${Environment.crmServiceUrl}/newprodserv/sitevisit_create?action=summary&page=$page';

  static String get visitTypeDropDown =>
      '${Environment.crmServiceUrl}/newprodserv/common_drop_down?page=1&action=visit_type';

  static String get interestLevelDropDown =>
      '${Environment.crmServiceUrl}/newprodserv/common_drop_down?page=1&action=interest_lvl';

  static String commonDropDown({int page = 1, String action = ''}) =>
      '${Environment.crmServiceUrl}/newprodserv/common_drop_down?page=$page&action=$action';

  static String get addInterestLead =>
      '${Environment.crmServiceUrl}/newprodserv/interested_lead';

  static String getInterestLead(String refId, String refType) =>
      '${Environment.crmServiceUrl}/newprodserv/interested_lead_summary?ref_id=$refId&ref_type=$refType';

  // ─────────────────────────────────────────
  // DOC SERVICE  (port 1002)
  // ─────────────────────────────────────────
  static String docDownload(String fileId) =>
      '${Environment.docServiceUrl}/docserv/doc_download/$fileId';

  // ─────────────────────────────────────────
  // MASTER SERVICE  (port 1001)
  // ─────────────────────────────────────────
  static String groupSubProduct(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.masterServiceUrl}/mstserv/get_grp_sub_product?$q';
  }

  static String get leaveType =>
      '${Environment.masterServiceUrl}/mstserv/leave_type?action=leave_request';

  static String mainCategory(int id, {int page = 1}) =>
      '${Environment.masterServiceUrl}/mstserv/productclassification/$id?page=$page';

  static String subCategory(int id, {int page = 1}) =>
      '${Environment.masterServiceUrl}/mstserv/productcat/$id?page=$page';

  static String product(int catId, int subCatId, {int page = 1}) =>
      '${Environment.masterServiceUrl}/mstserv/fetch_product_bycat_sub/cat/$catId/subcat/$subCatId?page=$page';

  static String productNameSearch({
    int page = 1,
    String query = '',
    String requestType = '',
  }) =>
      '${Environment.masterServiceUrl}/mstserv/search_mst_product_prpo?page=$page&query=$query&request_type=$requestType';

  static String specificationSearch({int page = 1, required String code}) =>
      '${Environment.masterServiceUrl}/mstserv/product_specification?page=$page&code=$code';

  static String commoditySearch({String query = '', int page = 1}) =>
      '${Environment.masterServiceUrl}/mstserv/searchcommodity?query=$query&page=$page';

  static String pdtClassType({dynamic data, int page = 1}) =>
      '${Environment.masterServiceUrl}/mstserv/pdtclasstype?data=$data&page=$page';

  static String productTypeSearch({int? page, String? data}) {
    final params = <String, String>{};
    if (page != null) params['page'] = '$page';
    if (data != null) params['data'] = data;
    final q = Uri(queryParameters: params).query;
    return '${Environment.masterServiceUrl}/mstserv/pdtclasstype${q.isNotEmpty ? '?$q' : ''}';
  }

  static String productSearch({String query = '', int page = 1}) =>
      '${Environment.masterServiceUrl}/mstserv/product_search_rm?query=$query&page=$page';

  static String uomSearch({int page = 1, String query = ''}) =>
      '${Environment.masterServiceUrl}/mstserv/uom_search?query=$query&page=$page';

  static String getBusinessSegments({String query = '', int page = 1}) =>
      '${Environment.masterServiceUrl}/mstserv/searchbusinesssegment?query=$query&page=$page';

  static String getCcSegments({String query = '', required String bsId}) =>
      '${Environment.masterServiceUrl}/mstserv/searchbs_cc?query=$query&bs_id=$bsId';

  static String bsSearch({String query = ''}) =>
      '${Environment.masterServiceUrl}/mstserv/searchbusinesssegment?query=$query';

  static String ccSearch({required String bsId, String query = ''}) =>
      '${Environment.masterServiceUrl}/mstserv/searchbs_cc?bs_id=$bsId&query=$query';

  static String getInventoryProduct(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.masterServiceUrl}/mstserv/product_search?$q';
  }

  // ─────────────────────────────────────────
  // PROJECT SERVICE  (port 1007)
  // ─────────────────────────────────────────
  static String blockDropdown({
    int page = 1,
    required String projectId,
    String name = '',
  }) =>
      '${Environment.projectServiceUrl}/prjserv/get_block_details?page=$page&project_id=$projectId&name=$name';

  static String projectDropdown({int page = 1, String name = ''}) =>
      '${Environment.projectServiceUrl}/prjserv/get_project_details?page=$page&name=$name';

  static String getFlatList({
    int page = 1,
    String name = '',
    required String floorId,
  }) =>
      '${Environment.projectServiceUrl}/prjserv/get_flat_details?page=$page&name=$name&floor_id=$floorId';

  static String getTowerDropdown(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.projectServiceUrl}/prjserv/get_tower_details?$q';
  }

  static String getFloorList({
    int page = 1,
    required String towerId,
    String name = '',
  }) =>
      '${Environment.projectServiceUrl}/prjserv/get_floor_details?page=$page&tower_id=$towerId&name=$name';

  static String flatDetail({
    required String projectId,
    String blockId = '',
    String towerId = '',
    String floorId = '',
    String flatId = '',
    String specsId = '',
    String bookingStatus = '',
    int page = 1,
  }) =>
      '${Environment.projectServiceUrl}/prjserv/flat_detail?project_id=$projectId'
      '&block_id=$blockId&tower_id=$towerId&floor_id=$floorId'
      '&flat_id=$flatId&specs_id=$specsId&booking_status=$bookingStatus&page=$page';

  static String utilDropdown({
    int page = 1,
    required String type,
    required String query,
  }) =>
      '${Environment.projectServiceUrl}/prjserv/util_dropdown?page=$page&type=$type&query=$query';

  static String carParkingDropdown({int page = 1, String name = ''}) =>
      '${Environment.projectServiceUrl}/prjserv/get_parktype_details?page=$page&name=$name';

  static String carParkingSummary({
    required String projectId,
    required String blockId,
    required String type,
  }) =>
      '${Environment.projectServiceUrl}/prjserv/carpark_mapping_summary?project_id=$projectId&block_id=$blockId&type=$type';

  static String carParkingDetail({
    required String carparkId,
    required String action,
    required String bookingStatus,
  }) =>
      '${Environment.projectServiceUrl}/prjserv/carpark_mapping_summary?carpark_id=$carparkId&action=$action&booking_status=$bookingStatus';

  // ─────────────────────────────────────────
  // SALES SERVICE  (port 1009)
  // ─────────────────────────────────────────
  static String get bookingStatusDropdown =>
      '${Environment.salesServiceUrl}/saleserv/bookingstatus_dropdown';

  static String get fetchSaleHeader =>
      '${Environment.salesServiceUrl}/saleserv/fetch_sale_header';

  static String get triggerQuotation =>
      '${Environment.salesServiceUrl}/saleserv/quotation_trigger_process';

  static String get invoiceHeaderMaker =>
      '${Environment.salesServiceUrl}/saleserv/invoice_header_maker';

  static String get collectionHeader =>
      '${Environment.salesServiceUrl}/saleserv/collectionheader_maker';

  static String collectionProofDownload(String id) =>
      '${Environment.salesServiceUrl}/saleserv/collection_proof_download/$id';

  static String get stageCreation =>
      '${Environment.salesServiceUrl}/saleserv/stage_creation';

  static String getStageDetails({
    required String saleId,
    required String stageDetailId,
    required String customerId,
  }) =>
      '${Environment.salesServiceUrl}/saleserv/customerwise_stage_amt?sale_id=$saleId&stage_detail_id=$stageDetailId&customer_id=$customerId';

  static String fetchCustFlatInfo(String customerId) =>
      '${Environment.salesServiceUrl}/saleserv/fetch_cust_flat_info?customer_id=$customerId';

  static String getInventorySummarySearch(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.salesServiceUrl}/saleserv/stock_ledger_summary?$q';
  }

  static String getCheckingStockBalance(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.salesServiceUrl}/saleserv/stock_running_bal?$q';
  }

  static String get stockActivityDropdown =>
      '${Environment.salesServiceUrl}/saleserv/CRUD_Stock_Activity';

  static String get createMaterialRequest =>
      '${Environment.salesServiceUrl}/saleserv/material_issue_request';

  static String get updateStatus =>
      '${Environment.salesServiceUrl}/saleserv/update_status';

  static String getCommonMaterialSummary(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.salesServiceUrl}/saleserv/common_material_summary?$q';
  }

  static String stockTransferHistory(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.salesServiceUrl}/saleserv/stock_transfer_history?$q';
  }

  static String getStockReport(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.salesServiceUrl}/saleserv/stock_report?$q';
  }

  static String commonTransferSummary(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.salesServiceUrl}/saleserv/common_transfer_summary?$q';
  }

  static String get approveTransfer =>
      '${Environment.salesServiceUrl}/saleserv/approve_transfer';

  static String get transferIssueRequest =>
      '${Environment.salesServiceUrl}/saleserv/transfer_issue_request';

  static String dashboardStockPercentage(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.salesServiceUrl}/saleserv/dashboard_stock_percentage?$q';
  }

  static String get fetchStockDashboard =>
      '${Environment.salesServiceUrl}/saleserv/fetch_stock_dashboard';

  static String stockTransaction(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.salesServiceUrl}/saleserv/stock_ledger_transaction?$q';
  }

  static String issueMainSummary(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.salesServiceUrl}/saleserv/issue_main_summary?$q';
  }

  static String downloadFile(String id) =>
      '${Environment.salesServiceUrl}/saleserv/download_file?file_id=$id';

  static String stockReportWithParent(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.salesServiceUrl}/saleserv/stock_report_with_parent?$q';
  }

  static String getInventoryDocumentSummarySearch({
    required String headerId,
    Map<String, dynamic> params = const {},
  }) {
    final merged = {'header_id': headerId, ...params};
    final q =
        Uri(queryParameters: merged.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.salesServiceUrl}/saleserv/stock_documents_summary?$q';
  }

  static String transferSummary(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.salesServiceUrl}/saleserv/transfer_summary?$q';
  }

  static String issueReqNo(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.salesServiceUrl}/saleserv/request_no_dropdown?$q';
  }

  static String get contractorDropdown =>
      '${Environment.salesServiceUrl}/saleserv/stock_running_bal';

  // ─────────────────────────────────────────
  // SMS SERVICE  (port 1008)
  // ─────────────────────────────────────────
  static String ticketOverallSummary(String employeeId) =>
      '${Environment.smsServiceUrl}/smsservice/ticket_overallsummary?employee_id=$employeeId';

  static String crmServiceRequest({
    required String customerId,
    int page = 1,
    int isServiceType = 2,
    String flatId = '',
    String category = '',
    String code = '',
    String projectId = '',
  }) =>
      '${Environment.smsServiceUrl}/smsservice/crm_service_request'
      '?customer_id=$customerId&page=$page&is_service_type=$isServiceType'
      '&flat_id=$flatId&category=$category&code=$code&project_id=$projectId';

  static String natureDropdown({int page = 1, required String assetName}) =>
      '${Environment.smsServiceUrl}/smsservice/natureofproblem?page=$page&asset_name=$assetName';

  static String natureSubDropdown({int page = 1, required String parentId}) =>
      '${Environment.smsServiceUrl}/smsservice/natureofproblem_new?page=$page&parent_id=$parentId';

  static String get addCrmServiceRequest =>
      '${Environment.smsServiceUrl}/smsservice/crm_service_request';

  // ─────────────────────────────────────────
  // HRMS SERVICE  (port 1023)
  // ─────────────────────────────────────────
  static String checkInOut(String mode) =>
      '${Environment.hrmsServiceUrl}/atdserv/check_in?mode=$mode';

  static String daySummary(String logDate) =>
      '${Environment.hrmsServiceUrl}/atdserv/day_log_summary?log_date=$logDate';

  static String get designationStatus =>
      '${Environment.hrmsServiceUrl}/taskserv/designation_wise_status';

  static String get designationNewStatus =>
      '${Environment.hrmsServiceUrl}/taskserv/designation_wise_new_status';

  static String get designationBasedNewStatus =>
      '${Environment.hrmsServiceUrl}/atdserv/designation_based_new_status';

  static String get leaveRequest =>
      '${Environment.hrmsServiceUrl}/atdserv/leave_request';

  static String leaveDetails(int leaveId) =>
      '${Environment.hrmsServiceUrl}/atdserv/leave_request/$leaveId';

  static String approveRejectLeaveRequest(int leaveId, String action) =>
      '${Environment.hrmsServiceUrl}/atdserv/leave_request/$leaveId?action=$action';

  static String cancelLeaveRequest(int leaveId) =>
      '${Environment.hrmsServiceUrl}/atdserv/leave_request/$leaveId?action=close';

  static String get applyLeaveRequest =>
      '${Environment.hrmsServiceUrl}/atdserv/leave_request';

  static String get taskSummary =>
      '${Environment.hrmsServiceUrl}/taskserv/common_task_summary';

  static String get taskStatusList =>
      '${Environment.hrmsServiceUrl}/taskserv/task_status_list';

  static String masterProjectList(String query) =>
      '${Environment.hrmsServiceUrl}/taskserv/mst_project_search/0?query=$query';

  static String moduleList(String query) =>
      '${Environment.hrmsServiceUrl}/taskserv/mst_module_search/0?query=$query';

  static String get clientList =>
      '${Environment.hrmsServiceUrl}/taskserv/trans_client_search';

  static String projectList(String clientId) =>
      '${Environment.hrmsServiceUrl}/taskserv/trans_project_search/$clientId';

  static String taskModuleList(String projectId) =>
      '${Environment.hrmsServiceUrl}/taskserv/trans_module_search/$projectId';

  static String teamLeadList(String query) =>
      '${Environment.hrmsServiceUrl}/taskserv/employeegroupmapping_create?query=$query&group_id=3';

  static String teamList(String query) =>
      '${Environment.hrmsServiceUrl}/taskserv/team_summary?action=team_wise&query=$query';

  static String get hierarchyEmployeeList =>
      '${Environment.hrmsServiceUrl}/taskserv/hierarchy_emp_summary';

  static String get createCommonTask =>
      '${Environment.hrmsServiceUrl}/taskserv/common_task_creation';

  static String get devType =>
      '${Environment.hrmsServiceUrl}/taskserv/dev_type_dd';

  static String sprintList(String query) =>
      '${Environment.hrmsServiceUrl}/taskserv/sprint?query=$query';

  static String get timesheetSummary =>
      '${Environment.hrmsServiceUrl}/taskserv/timesheet';

  static String get recentTask =>
      '${Environment.hrmsServiceUrl}/taskserv/get_recent_project';

  static String projectEmployee(
          {required String projectId, required String query}) =>
      '${Environment.hrmsServiceUrl}/taskserv/project_employee_summary?action=project&query=$query&page=1&project_id=$projectId';

  static String dependencyList(
          {required String mappingId, required String query}) =>
      '${Environment.hrmsServiceUrl}/taskserv/task_dependency_dd?page=1&query=$query&mapping_id=$mappingId';

  static String get priorityList =>
      '${Environment.hrmsServiceUrl}/taskserv/task_dropdown?action=priority';

  static String get meetingList =>
      '${Environment.hrmsServiceUrl}/taskserv/task_dropdown?action=meeting';

  static String get employeeWorkShift =>
      '${Environment.hrmsServiceUrl}/hrmsserv/employee_workshift';

  static String dayLog(int empId, String logDate) =>
      '${Environment.hrmsServiceUrl}/atdserv/per_day_log/$empId?log_date=$logDate';

  static String get attendanceFixRequest =>
      '${Environment.hrmsServiceUrl}/atdserv/attendance_change_request';

  static String get approveAttendanceChangeRequest =>
      '${Environment.hrmsServiceUrl}/atdserv/change_request_approval';

  static String get cancelAttendanceChangeRequest =>
      '${Environment.hrmsServiceUrl}/atdserv/change_request_approval';

  static String get fetchAttendanceChangeRequestSummary =>
      '${Environment.hrmsServiceUrl}/atdserv/attendance_change_request';

  static String get fetchCheckinApproval =>
      '${Environment.hrmsServiceUrl}/atdserv/fetch_checkin_approval';

  static String get approveCheckin =>
      '${Environment.hrmsServiceUrl}/atdserv/checkin_approve';

  static String get bulkCheckin =>
      '${Environment.hrmsServiceUrl}/atdserv/bulk_checkin_approve';

  static String get sprintListPaged =>
      '${Environment.hrmsServiceUrl}/taskserv/sprint';

  static String get meetingLogs =>
      '${Environment.hrmsServiceUrl}/taskserv/meeting_log';

  static String searchCommonEmployee(
          {String query = '', int page = 1, required String empId}) =>
      '${Environment.hrmsServiceUrl}/taskserv/emp_common_search?query=$query&page=$page&emp_id=$empId';

  static String get googleValidation =>
      '${Environment.hrmsServiceUrl}/taskserv/user_google_val';

  static String leaveHistory(int month, int year) =>
      '${Environment.hrmsServiceUrl}/atdserv/employee_history?month=$month&year=$year';

  static String get odRequest =>
      '${Environment.hrmsServiceUrl}/atdserv/od_request';

  static String odRequestById(int odId) =>
      '${Environment.hrmsServiceUrl}/atdserv/get_od_request/$odId';

  static String viewTaskSummary(int taskId, String action) =>
      '${Environment.hrmsServiceUrl}/taskserv/task/$taskId?action=$action';

  static String deactivateTask(int taskId, String action) =>
      '${Environment.hrmsServiceUrl}/taskserv/task/$taskId?action=$action';

  static String searchStoriesMapping({String query = '', required int page}) =>
      '${Environment.hrmsServiceUrl}/taskserv/stories?query=$query&page=$page';

  static String get addStoryMapping =>
      '${Environment.hrmsServiceUrl}/taskserv/common_task_creation?action=story_mapping';

  static String searchTeam({String query = '', required int page}) =>
      '${Environment.hrmsServiceUrl}/taskserv/team?query=$query&page=$page';

  static String updateTaskStatus(int taskId, String action) =>
      '${Environment.hrmsServiceUrl}/taskserv/task/$taskId?action=$action';

  static String get approveTimeSheet =>
      '${Environment.hrmsServiceUrl}/atdserv/atd_timesheet_approve';

  static String deleteTimeSheet(int id) =>
      '${Environment.hrmsServiceUrl}/taskserv/time_sheet_delete/$id';

  // ─────────────────────────────────────────
  // TA SERVICE  (port 1019)
  // ─────────────────────────────────────────
  static String travelMakerSummary(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/nac_tourdata?$q';
  }

  static String empDetails(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/emp_details_get?$q';
  }

  static String tourReasonList({String name = '', int page = 1}) =>
      '${Environment.taServiceUrl}/taserv/tourreason?name=$name&page=$page';

  static String get tourSubmit => '${Environment.taServiceUrl}/taserv/tour';

  static String tourDataGet(int tourId) =>
      '${Environment.taServiceUrl}/taserv/tourdata/$tourId';

  static String documentDataGet(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/document_get?$q';
  }

  static String get tourApprove =>
      '${Environment.taServiceUrl}/taserv/tourapprove';

  static String get tourReject =>
      '${Environment.taServiceUrl}/taserv/tourreject';

  static String get tourReturn =>
      '${Environment.taServiceUrl}/taserv/tourreturn';

  static String get tourForward =>
      '${Environment.taServiceUrl}/taserv/tourforward';

  static String get tourCancel =>
      '${Environment.taServiceUrl}/taserv/tourcancel';

  static String holidayCheck(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/holiday_check?$q';
  }

  static String commonDropDownGet(String key) =>
      '${Environment.taServiceUrl}/taserv/common_dropdown_get/$key';

  static String clientListTa(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/frequent_client?$q';
  }

  static String cityList(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/frequent_city?$q';
  }

  static String deleteRequirement(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/delete_travel_requirements?$q';
  }

  static String get adminReserv =>
      '${Environment.taServiceUrl}/taserv/admin_reserv';

  static String get reqReject =>
      '${Environment.taServiceUrl}/taserv/requirement_reject';

  static String onBehalfList(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/nac_onbehalf_emp_get?$q';
  }

  static String travelApproveSummary(Map<String, dynamic> params) {
    final type = params['type'];
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/nac_tourapprove/$type?$q';
  }

  static String getExpenseSummary(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/expense_summary?$q';
  }

  static String expenseApprovalSummary(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/nac_tourapprove/claim?$q';
  }

  static String getFuelAllowanceSummary({
    required int page,
    String? claimAmount,
    String? monthYear,
    int? status,
  }) {
    var url =
        '${Environment.taServiceUrl}/taserv/fuel_allowance_summary?page=$page';
    if (claimAmount != null) url += '&claim_amount=$claimAmount';
    if (monthYear != null) url += '&month_year=$monthYear';
    if (status != null) url += '&status=$status';
    return url;
  }

  static String get getEmployeeDetailsForFuel =>
      '${Environment.taServiceUrl}/taserv/emp_details_get';

  static String get modeOfTravel =>
      '${Environment.taServiceUrl}/taserv/common_dropdown_get/modeoftravel';

  static String get modeOfTravelAlt =>
      '${Environment.taServiceUrl}/taserv/common_dropdown_get/mode_of_travel';

  static String get eligibleAmountFuel =>
      '${Environment.taServiceUrl}/taserv/eligible_amount_fuel';

  static String get fuelAllowanceCreate =>
      '${Environment.taServiceUrl}/taserv/fuel_allowance_create';

  static String getDateRelaxation({String tourNo = '', int? page}) =>
      '${Environment.taServiceUrl}/taserv/date_relaxation?tour_no=$tourNo${page != null ? '&page=$page' : ''}';

  static String get updateDateRelaxationStatus =>
      '${Environment.taServiceUrl}/taserv/date_relaxation';

  static String getChatSummary({int page = 1}) =>
      '${Environment.taServiceUrl}/taserv/chat_summary?page=$page';

  static String deleteChat(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/delete_chat_box?$q';
  }

  static String getChatBox({required String tourId, int page = 1}) =>
      '${Environment.taServiceUrl}/taserv/chat_box?tourid=$tourId&page=$page';

  static String get postChatBox =>
      '${Environment.taServiceUrl}/taserv/chat_box';

  static String postChatBoxView(String tourId) =>
      '${Environment.taServiceUrl}/taserv/chat_box_view?tourid=$tourId';

  static String adminSummary(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/admin_summary?$q';
  }

  static String getLodging(String tourNo) =>
      '${Environment.taServiceUrl}/taserv/lodging/tour/$tourNo';

  static String get lodgingCreate =>
      '${Environment.taServiceUrl}/taserv/lodging';

  static String get lodgingLogic =>
      '${Environment.taServiceUrl}/taserv/lodging/logic';

  static String insertCity({required String cityName, required int page}) =>
      '${Environment.taServiceUrl}/taserv/insert_ta_city?city_name=$cityName&page=$page';

  static String getLocalConv(String tourNo) =>
      '${Environment.taServiceUrl}/taserv/localconv/tour/$tourNo';

  static String get localConvCreate =>
      '${Environment.taServiceUrl}/taserv/localconv';

  static String get localConvLogic =>
      '${Environment.taServiceUrl}/taserv/localconv/logic';

  static String get dailyDeimLogic =>
      '${Environment.taServiceUrl}/taserv/dailydeim/logic';

  static String get dailyDeimCreate =>
      '${Environment.taServiceUrl}/taserv/dailydeim';

  static String getDailyReimbursement(String tourNo) =>
      '${Environment.taServiceUrl}/taserv/dailydeim/tour/$tourNo';

  static String getAssociatedExpense(String tourNo) =>
      '${Environment.taServiceUrl}/taserv/associate/tour/$tourNo';

  static String get associateCreate =>
      '${Environment.taServiceUrl}/taserv/associate';

  static String getTravelExpense(String tourNo) =>
      '${Environment.taServiceUrl}/taserv/travel/tour/$tourNo';

  static String get travelSubmit => '${Environment.taServiceUrl}/taserv/travel';

  static String documentGet({int tourId = 0, required String expId}) =>
      '${Environment.taServiceUrl}/taserv/document_get?tour_id=$tourId&ref_type=2&requirement_type=$expId';

  static String get documentInsert =>
      '${Environment.taServiceUrl}/taserv/document_insert';

  static String deleteDocument(String docId) =>
      '${Environment.taServiceUrl}/taserv/particular_doc_get/$docId';

  static String expenseDelete(
          {required String tourId, required String expId}) =>
      '${Environment.taServiceUrl}/taserv/expense_delete/$tourId/tour/$expId';

  static String getCCBS(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/ccbs_get?$q';
  }

  static String get expenseSubmit =>
      '${Environment.taServiceUrl}/taserv/expense/submit';

  static String getExpenseDetails(String tourNo) =>
      '${Environment.taServiceUrl}/taserv/claimreq/tour/$tourNo';

  static String getApprovalFlow(String tourNo) =>
      '${Environment.taServiceUrl}/taserv/approval_flow_get?type=all&tourid=$tourNo';

  static String get expenseList =>
      '${Environment.taServiceUrl}/taserv/expenselist';

  static String cancelDataGet(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/cancelled_data?$q';
  }

  static String listForCancelGet(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/approved_data?$q';
  }

  static String get onBehalfDataGet =>
      '${Environment.taServiceUrl}/taserv/onbehalf_emp_get';

  static String bookingDetails(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.taServiceUrl}/taserv/get_requirements_admin?$q';
  }

  static String get accBooking =>
      '${Environment.taServiceUrl}/taserv/accommodation_booking_admin';

  static String get cabBooking =>
      '${Environment.taServiceUrl}/taserv/cab_booking_admin';

  static String get airBooking =>
      '${Environment.taServiceUrl}/taserv/air_booking_admin';

  static String get busBooking =>
      '${Environment.taServiceUrl}/taserv/bus_booking_admin';

  static String get trainBooking =>
      '${Environment.taServiceUrl}/taserv/train_booking_admin';

  static String getIncidentalExpense(String tourNo) =>
      '${Environment.taServiceUrl}/taserv/incidental/tour/$tourNo';

  static String getPackagingFreight(String tourNo) =>
      '${Environment.taServiceUrl}/taserv/packingmvg/tour/$tourNo';

  static String getLocalDeputation(String tourNo) =>
      '${Environment.taServiceUrl}/taserv/localdeputation/tour/$tourNo';

  static String getFuelAllowanceDetails(String tourId) =>
      '${Environment.taServiceUrl}/taserv/fuel_allowance_details/$tourId';

  static String getFuelDocuments(String tourId) =>
      '${Environment.taServiceUrl}/taserv/fuel_document_get?tour_id=$tourId&ref_type=4';

  static String get fuelApproval =>
      '${Environment.taServiceUrl}/taserv/fuel_approve';

  static String get fuelReject =>
      '${Environment.taServiceUrl}/taserv/fuel_reject';

  static String get fuelReturn =>
      '${Environment.taServiceUrl}/taserv/fuel_return';

  static String fuelApprovalFlow(
          {required String type, required String tourId}) =>
      '${Environment.taServiceUrl}/taserv/fuel_approval_flow_get?type=$type&tour_id=$tourId';

  static String get fuelAllowanceUpload =>
      '${Environment.taServiceUrl}/taserv/fuelallowance_upload';

  static String get fuelAllowanceDownload =>
      '${Environment.taServiceUrl}/taserv/fuelallowance_download';

  static String fuelRmSkip(String tourId) =>
      '${Environment.taServiceUrl}/taserv/fuel_rm_skip/$tourId';

  static String get employeeBaseGet =>
      '${Environment.taServiceUrl}/taserv/employee_base_get';

  static String approverList({
    String name = '',
    int page = 1,
    int branch = 0,
    String type = 'tour',
  }) =>
      '${Environment.taServiceUrl}/taserv/branch_approver_get/$type/branch/$branch?name=$name&page=$page';

  // ─────────────────────────────────────────
  // PRPO SERVICE  (port 1004)
  // ─────────────────────────────────────────
  static String get branchIndentMakerSummary =>
      '${Environment.prpoServiceUrl}/prserv/branchrequest_maker_summary';

  static String get branchIndentApproverSummary =>
      '${Environment.prpoServiceUrl}/prserv/branchrequest_approver_summary';

  static String getBranchIndentDetails(int id) =>
      '${Environment.prpoServiceUrl}/prserv/branchrequest_edit/$id';

  static String branchIndentDetails(int id) =>
      '${Environment.prpoServiceUrl}/prserv/branchrequest_edit/$id';

  static String get branchIndentAction =>
      '${Environment.prpoServiceUrl}/prserv/branch_request_action';

  static String prTransaction(int id, Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.prpoServiceUrl}/prserv/prtran/$id?$q';
  }

  static String pcaSearch(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.prpoServiceUrl}/prserv/search_pcano?$q';
  }

  static String get createIndependent =>
      '${Environment.prpoServiceUrl}/prserv/pr_create_indep';

  static String get pcaDetailsForCreate =>
      '${Environment.prpoServiceUrl}/prserv/pca_details_for_pr_create';

  static String get createBranchIndent =>
      '${Environment.prpoServiceUrl}/prserv/pr_branch_create';

  static String getBranchIndentEdit(int id) =>
      '${Environment.prpoServiceUrl}/prserv/pr_branch_edit/$id';

  static String independentDetailView(int id) =>
      '${Environment.prpoServiceUrl}/prserv/pr_independent_detail_view/$id';

  static String get updateBranchIndent =>
      '${Environment.prpoServiceUrl}/prserv/pr_branch_update';

  static String get prpoCommonReports =>
      '${Environment.prpoServiceUrl}/prserv/prpo_common_reports';

  static String getContractorDropdown(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.prpoServiceUrl}/prserv/supplier_and_word_order_um?$q';
  }

  // ─────────────────────────────────────────
  // VENDOR SERVICE  (port 1003)
  // ─────────────────────────────────────────
  static String get vendorSummary =>
      '${Environment.vendorServiceUrl}/vendserv/vendor?page=1';

  static String get customerSearch =>
      '${Environment.vendorServiceUrl}/vendserv/customer_search';

  static String classificationDropdown(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/type?$q';
  }

  static String headerNameDropdown(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendusrserv/ven_searchheader?$q';
  }

  static String getBranchActivity({
    required String branchId,
    required int page,
    required int pageSize,
  }) =>
      '${Environment.vendorServiceUrl}/vendserv/branch/$branchId/activity?page=$page&page_size=$pageSize';

  static String getBranchPayment({
    required String branchId,
    required int page,
    required int pageSize,
  }) =>
      '${Environment.vendorServiceUrl}/vendserv/branch/$branchId/payment?page=$page&page_size=$pageSize';

  static String getBranchCatalog({
    required String branchId,
    required int page,
    required int pageSize,
    required int isSummary,
  }) =>
      '${Environment.vendorServiceUrl}/vendserv/supplieractivitydtl/$branchId/catelog?page=$page&page_size=$pageSize&is_summary=$isSummary';

  static String categorySearch(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/ven_categoryname_search?$q';
  }

  static String paymodeSearch(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/ven_paymode_search?$q';
  }

  static String ifscSearch(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/ven_ifsc_search?$q';
  }

  static String branchPaymentCreate(String branchId) =>
      '${Environment.vendorServiceUrl}/vendserv/branch/$branchId/payment';

  static String getVendorAttachment(String attachmentId) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor_attactments/$attachmentId';

  static String gstCategoryDropdown(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/composite?$q';
  }

  static String get paymentActiveFlag =>
      '${Environment.vendorServiceUrl}/vendserv/payment_activeflag';

  static String relationshipCategoryDropdown(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/group?$q';
  }

  static String relationshipSubCategoryDropdown(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/customercategory?$q';
  }

  static String orgType(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/org_type?$q';
  }

  static String relationshipType(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/classification?$q';
  }

  static String riskType(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/risktype?$q';
  }

  static String msmeType(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/get_msmetype?$q';
  }

  static String maritalStatus(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendserv/material_status?$q';
  }

  static String pinCodeSearch(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/ven_pincodesearch?$q';
  }

  static String designationSearch(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/ven_designation_search?$q';
  }

  static String get searchRiskCategory =>
      '${Environment.vendorServiceUrl}/vendmastserv/search_riskcategory';

  static String get panValidate =>
      '${Environment.vendorServiceUrl}/vendserv/pan_validate';

  static String vendorStatus(int id) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$id/status';

  static String modificationApprove(int id) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$id/modification_approve';

  static String quitModification(int vendorId) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$vendorId/modification_quit';

  static String get vendorCreate =>
      '${Environment.vendorServiceUrl}/vendserv/vendor';

  static String getVendorData(int id) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$id';

  static String getBranchData({required int id, required int page}) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$id/branch?page=$page';

  static String getClientData({required int id, required int page}) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$id/client?page=$page';

  static String getContractorData({required int id, required int page}) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$id/contractor?page=$page';

  static String getTaxData({required int id, required int page}) =>
      '${Environment.vendorServiceUrl}/vendserv/branch/$id/suppliertax?page=$page';

  static String getProductData({required int id, required int page}) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$id/product?page=$page';

  static String rmValidation(int vendorId) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$vendorId/vendorrm_validation';

  static String vendorDocuments(int vendorId) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$vendorId/vendordocuments';

  static String getDocumentData({required int id, required int page}) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$id/vendordocument?page=$page';

  static String getTransactionData({required int id, required int page}) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$id/history?page=$page';

  static String getHistoryView(int id) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$id/history_view';

  static String getModificationView(int id) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$id/modication_view';

  static String gstValidate(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendserv/validate?$q';
  }

  static String vendorSearch(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendserv/search?$q';
  }

  static String activateDeactivateDocument(int vendorId, String type) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$vendorId/vendordocument?type=$type';

  static String get createCustomer =>
      '${Environment.vendorServiceUrl}/vendserv/customer_branch_create';

  static String modificationRequest(int vendorId) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$vendorId/modification_request';

  static String branchCreate(int vendorId) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$vendorId/branch';

  static String clientCreate(int vendorId) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$vendorId/client';

  static String contractorCreate(int vendorId) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$vendorId/contractor';

  static String getTax(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/ven_tax_search?$q';
  }

  static String getSubTax(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/ven_subtax_search?$q';
  }

  static String getTaxRate(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/ven_taxrate_search?$q';
  }

  static String taxCreate(int vendorId) =>
      '${Environment.vendorServiceUrl}/vendserv/branch/$vendorId/suppliertax';

  static String getDocumentGroup(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/documentgroup?$q';
  }

  static String createVendorDoc(int partnerId) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$partnerId/vendordocument';

  static String productCreate(int vendorId) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$vendorId/product';

  static String getEditBranch({required int vendorId, required int branchId}) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$vendorId/branch/$branchId';

  static String getSupplierTaxEdit({
    required int vendorId,
    required int supplierId,
  }) =>
      '${Environment.vendorServiceUrl}/vendserv/branch/$vendorId/suppliertax/$supplierId';

  static String supplierTaxUpdate(int vendorId) =>
      '${Environment.vendorServiceUrl}/vendserv/branch/$vendorId/suppliertax';

  static String taxDelete({required int vendorId, required int supplierId}) =>
      '${Environment.vendorServiceUrl}/vendserv/branch/$vendorId/suppliertax/$supplierId';

  static String getEditProduct(
          {required int vendorId, required int productId}) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$vendorId/product/$productId';

  static String productUpdate(int vendorId) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$vendorId/product';

  static String getEditDocument({required int vendorId, required int docId}) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$vendorId/vendordocument/$docId';

  static String updateDocument(int vendorId) =>
      '${Environment.vendorServiceUrl}/vendserv/vendor/$vendorId/vendordocument';

  static String get customerStatus =>
      '${Environment.vendorServiceUrl}/vendserv/customer_status';

  static String deleteKyc({required int customerId, required int kycId}) =>
      '${Environment.vendorServiceUrl}/vendserv/customer_kyc_delete/$customerId/$kycId';

  static String get verifyKyc =>
      '${Environment.vendorServiceUrl}/vendserv/customer_kycverified';

  static String updateKyc(int customerId) =>
      '${Environment.vendorServiceUrl}/vendserv/customer_kyccreate/$customerId';

  static String customerNewEdit(int id) =>
      '${Environment.vendorServiceUrl}/vendserv/customer_branch_summary/$id';

  static String customerModificationRequest(
      int id, Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendserv/vendor/$id/cus_modification_request?$q';
  }

  static String getCustomerModificationView(int customerId) =>
      '${Environment.vendorServiceUrl}/vendserv/customer_modification_view/$customerId';

  static String getCustomerView(int id) =>
      '${Environment.vendorServiceUrl}/vendserv/customer_view/$id';

  static String getCustomerKYCView({required int id, required int pageNo}) =>
      '${Environment.vendorServiceUrl}/vendserv/customer_kyccreate/$id?page=$pageNo';

  static String getActivityById({
    required String branchId,
    required String activityId,
  }) =>
      '${Environment.vendorServiceUrl}/vendserv/branch/$branchId/activity/$activityId';

  static String updateActivity(String branchId) =>
      '${Environment.vendorServiceUrl}/vendserv/branch/$branchId/activity';

  static String getDepartmentList(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendusrserv/ven_searchdepartment?$q';
  }

  static String getActivityDescriptionList(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/create_activity?$q';
  }

  static String getDesignationList(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendmastserv/ven_designation_search?$q';
  }

  static String addBranchActivity(String branchId) =>
      '${Environment.vendorServiceUrl}/vendserv/branch/$branchId/activity';

  static String uomVendorSearch({int page = 1, String query = ''}) =>
      '${Environment.vendorServiceUrl}/vendmastserv/ven_uom_search?page=$page&query=$query';

  static String catalogCreate(String supplierId) =>
      '${Environment.vendorServiceUrl}/vendserv/supplieractivitydtl/$supplierId/catelog';

  static String getCatalogDetails({
    required String supplierId,
    required String catalogId,
  }) =>
      '${Environment.vendorServiceUrl}/vendserv/supplieractivitydtl/$supplierId/catelog/$catalogId';

  static String deleteCatalog({
    required String supplierId,
    required String catalogId,
  }) =>
      '${Environment.vendorServiceUrl}/vendserv/supplieractivitydtl/$supplierId/catelog/$catalogId';

  static String get configurationSearch =>
      '${Environment.vendorServiceUrl}/vendmastserv/product_configuration';

  static String get modelSearch =>
      '${Environment.vendorServiceUrl}/vendmastserv/productmakemodel';

  static String get makeSearch =>
      '${Environment.vendorServiceUrl}/vendmastserv/productmakemodel';

  static String activityDropdown(Map<String, dynamic> params) {
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.vendorServiceUrl}/vendserv/supplier_activity_list?$q';
  }

  static String employeeList(Map<String, dynamic> params) {
    final branch = params['branch'];
    final q =
        Uri(queryParameters: params.map((k, v) => MapEntry(k, '$v'))).query;
    return '${Environment.userServiceUrl}/prserv/branchwise_employee_get/$branch?$q';
  }
}
