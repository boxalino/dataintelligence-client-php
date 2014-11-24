namespace java com.boxalino.dataintelligence.api.thrift
namespace php com.boxalino.dataintelligence.api.thrift

/**
 * This enumeration defines the possible exception states returned by Boxalino Data Intelligence Thrift API
 *
 * <dl>
 * <dt>GENERAL_EXCEPTION</dt>
 * <dd>general case of exception (no special detailed provided)</dd>
 *
 * <dt>INVALID_CREDENTIALS</dt>
 * <dd>the provided credentials to retrieve an authentication token are not valid (wrong username, password or both)</dd>
 *
 * <dt>BLOCKED_USER</dt>
 * <dd>your user has been blocked (but it doesn't necessarily mean your account has been blocked)</dd>
 *
 * <dt>BLOCKED_ACCOUNT</dt>
 * <dd>your account has been blocked, you must contact Boxalino (<a href="mailto:support@boxalino.com">support@boxalino.com</a>) to know the reasons of this blocking.</dd>
 *
 * <dt>INVALID_AUTHENTICATION_TOKEN</dt>
 * <dd>the provided authentication token is invalid (wrong, or no more valid), you should get a new one by calling the GetAuthentication service.</dd>
 *
 * <dt>INVALID_NEW_PASSWORD</dt>
 * <dd>specific to the service function UpdatePassword: means that the new password is not correct (should be at least 8 characters long and not contain any punctuation)</dd>
 * 
 * <dt>INVALID_CONFIGURATION_VERSION</dt>
 * <dd>the provided configuration object contains a configuration version number which doesn't exists or cannot be accessed</dd>
 * </dl>
 * 
 * <dt>INVALID_DATASOURCE</dt>
 * <dd>the provided XML data source is not correct (see documentation of the data source XML format)</dd>
 * </dl>
 * 
 * <dt>NON_EXISTING_CONTENT_ID</dt>
 * <dd>the provided content to be changed (updated, deleted, etc.) is defined with a content id which doesn't exists</dd>
 * </dl>
 * 
 * <dt>ALREADY_EXISTING_CONTENT_ID</dt>
 * <dd>the provided content id to be created already exists</dd>
 * </dl>
 * 
 * <dt>INVALID_CONTENT_ID</dt>
 * <dd>the provided content id doesn't not match the requested format (less than 50 alphanumeric characters without any punctuation or accent)</dd>
 * </dl>
 * 
 * <dt>INVALID_CONTENT</dt>
 * <dd>the provided content data are not correctly set</dd>
 * </dl>
 * 
 * <dt>INVALID_LANGUAGE</dt>
 * <dd>one of the provided languages has not been defined for this account</dd>
 * </dl>
 */
enum DataIntelligenceServiceExceptionNumber {
	GENERAL_EXCEPTION = 1,
	INVALID_CREDENTIALS = 2,
	BLOCKED_USER = 3,
	BLOCKED_ACCOUNT = 4,
	INVALID_AUTHENTICATION_TOKEN = 5,
	INVALID_NEW_PASSWORD = 6,
	INVALID_CONFIGURATION_VERSION = 7,
	INVALID_DATASOURCE = 8,
	NON_EXISTING_CONTENT_ID = 9,
	ALREADY_EXISTING_CONTENT_ID = 10,
	INVALID_CONTENT_ID = 11,
	INVALID_CONTENT = 12,
	INVALID_LANGUAGE = 13,
	DUPLICATED_FILE_ID = 14,
	EMPTY_COLUMNS_LIST = 15,
	NON_EXISTING_FILE = 16,
        INVALID_RANGE = 17
}

/**
 * This exception is raised by all the BoxalinoDataIntelligence service function in case of a problem
 *
 * <dl>
 * <dt>exceptionNumber</dt>
 * <dd>indicate the exception number based on the enumeration DataIntelligenceServiceExceptionNumber</dd>
 * <dt>message</dt>
 * <dd>a textual message to explain the error conditions more in details</dd>
 * </dl>
 */
exception DataIntelligenceServiceException {
	1: required DataIntelligenceServiceExceptionNumber exceptionNumber
	2: required string message
}

/**
 * This structure defines the parameters to be send to receive an authentication token (required by all the other services)
 *
 * <dl>
 * <dt>account</dt>
 * <dd>	the name of your account (as provided to you by Boxalino team, if you don't have an account, contact <a href="mailto:support@boxalino.com">support@boxalino.com</a>)</dd>
 * <dt>username</dt>
 * <dd>	usually the same value as account (but can be different for users with smaller rights, if you don't have a username, contact <a href="mailto:support@boxalino.com">support@boxalino.com</a>)</dd>
 * <dt>password</dt>
 * <dd>	as provided by Boxalino, or according to the last password update you have set. If you lost your password, contact <a href="mailto:support@boxalino.com">support@boxalino.com</a>)</dd>
 * </dl>
 */
struct AuthenticationRequest {
	1: required string account,
	2: required string username,
	3: required string password
}

/**
 * This structure defines the authentication object (to pass as authentication proof to all function and services)
 *
 * <dl>
 * <dt>authenticationToken</dt>
 * <dd>the return authentication token is a string valid for one hour</dd>
 * </dl>
 */
struct Authentication {
	1: required string authenticationToken
}

/**
 * This enumeration defines the version type. All contents are versioned, normally, you want to change the current development version and then, when finished, publish it (so it becomes the new production version and a new development version is created), but it is also possible to access the production version directly
 *
 * <dl>
 * <dt>CURRENT_DEVELOPMENT_VERSION</dt>
 * <dd>this is the normal case, as you want to retrieve the current dev version of your account configuration and not touch the production one</dd>
 *
 * <dt>CURRENT_PRODUCTION_VERSION</dt>
 * <dd>this should only be used in rare cases where you want to recuperate information from the production configuration, but be careful in changing this version as it will immediately affect your production processes!</dd>
 * </dl>
 */
enum ConfigurationVersionType {
	CURRENT_DEVELOPMENT_VERSION = 1,
	CURRENT_PRODUCTION_VERSION = 2,
}

/**
 * This structure defines a configuration version of your account. It must be provided to all functions accessing / updating or removing information from your account configuration
 *
 * <dl>
 * <dt>configurationVersionNumber</dt>
 * <dd>an internal number identifying the configuration version</dd>
 * </dl>
 */
struct ConfigurationVersion {
	1: required i16 configurationVersionNumber
}

/**
 * This structure defines a configuration difference (somethin which has changed between two configuration versions)
 *
 * <dl>
 * <dt>contentType</dt>
 * <dd>the type of content which has changed (e.g.: 'field')</dd>
 * <dt>contentId</dt>
 * <dd>the content id which has changed (e.g: a field id)</dd>
 * <dt>parameterName</dt>
 * <dd>the content parameter which has changed (e.g.: a field type)</dd>
 * <dt>contentSource</dt>
 * <dd>the string encoded value of the content parameter value of the source configuration</dd>
 * <dt>contentDestination</dt>
 * <dd>the string encoded value of the content parameter value of the destination configuration</dd>
 * </dl>
 */
struct ConfigurationDifference {
	1: required string contentType,
	2: required string contentId,
	3: required string parameterName,
	4: required string contentSource,
	5: required string contentDestination
}

/**
 * This structure defines a data Field. A field covers any type of data property (customer property, product properties, etc.). Fields are global for all data sources, but can be used only for special data sources and ignored for others. This grants that the properties are always ready to unify values from different sources, but they don't have to.
 *
 * <dl>
 * <dt>fieldId</dt>
 * <dd>a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters</dd>
 * </dl>
 */
struct Field {
	1: required string fieldId
}

/**
 * This structure defines a data ProcessTask. A process task covers any kind of process task to be executed by the system.
 *
 * <dl>
 * <dt>processTaskId</dt>
 * <dd>a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters</dd>
 * </dl>
 */
struct ProcessTask {
	1: required string processTaskId
}

/**
 * This structure defines a data synchronisation process task. It is used to get the data from external systems and process it.
 *
 * <dl>
 * <dt>processTaskId</dt>
 * <dd>a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters</dd>
 * <dt>inputs</dt>
 * <dd>list of data sources which should be used to get data from</dd>
 * <dt>outputs</dt>
 * <dd>list of data exports which should be used to push the data into</dd>
 * <dt>dev</dt>
 * <dd>defines if it is dev version of the task process</dd>
 * <dt>delta</dt>
 * <dd>defines if this particular task process is differential</dd>
 * </dl>
 */
struct DataSyncProcessTask {
	1: required string processTaskId,
	2: required list<DataSource> inputs,
	3: required list<DataExport> outputs,
	4: required bool dev = false,
	5: required bool delta = false
}

/**
 * This structure defines a task Scheduling. A scheduling is a collection of process tasks to be executed one after the other by the system.
 *
 * <dl>
 * <dt>schedulingId</dt>
 * <dd>a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters</dd>
 * </dl>
 */
struct Scheduling {
	1: required string schedulingId
}

/**
 * This structure defines a task RecommendationBlock. A RecommendationBlock is a visual block of recommendation for one page of your web-site (product detail page, basket page, etc.) you can have several recommendation blocks on the same page.
 *
 * <dl>
 * <dt>recommendationBlockId</dt>
 * <dd>a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters</dd>
 * </dl>
 */
struct RecommendationBlock {
	1: required string recommendationBlockId
}

/**
 * This structure defines a data source. Data source is used to get the data from external systems into DI.
 * <dl>
 * <dt>dataSourceId</dt>
 * <dd>a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters</dd>
 * </dl>
 */
struct DataSource {
	1: required string dataSourceId
}

/**
 * This structure defines a data source type used to get the data from reference csv files defined with the API
 * <dl>
 * <dt>dataSourceId</dt>
 * <dd>a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters</dd>
 * <dt>extendedDataSourceId</dt>
 * <dd>identifier of the data source which will be extended by this data source</dd>
 * </dl>
 */
struct ReferenceCSVDataSource {
	1: required string dataSourceId,
	2: required string extendedDataSourceId
}

/**
 * This structure defines a data export type used to push processed data into
 * <dl>
 * <dt>dataExportId</dt>
 * <dd>a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters</dd>
 * </dl>
 */
struct DataExport {
	1: required string dataExportId
}

enum Language {
	GERMAN = 1,
	FRENCH = 2,
	ENGLISH = 3,
	ITALIAN = 4,
	SPANISH = 5,
	DUTCH = 6,
	PORTUGUESE = 7,
	SWEDISH = 8,
	ARABIC = 9,
	RUSSIAN = 10,
	JAPANESE = 11,
	KOREAN = 12,
	TURKISH = 13,
	VIETNAMESE = 14,
	POLISH = 15,
	UKRAINIAN = 16,
	CHINESE_MANDARIN = 17,
	OTHER = 100
}

/**
 * This structure defines a data EmailCampaign. A campaign is a parameter holder for a campaign execution. It should not change at each sending, but the parameters (especially cmpid) can be
 * (should) be changed before any new campaign sending (if new campid applies). For the case of trigger campaigns, the cmpid (and other parameters) usually don't change, but for the case of newsletter campaigns, very often each sending has a different id. In this case, the cmpid must be updated (and the dev configuration should be published) every time.
 * <dl>
 * <dt>campaignId</dt>
 * <dd>a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters</dd>
 * <dt>cmpid</dt>
 * <dd>the running campaign id which is often specific to the running of a specific newsletter e-mail (should be changed every time before sending a blast e-mail with the new value (don't forget to publish the dev configuration)</dd>
 * <dt>dateTime</dt>
 * <dd>the dateTime at which the campaign will be sent (cannot be in the past when the campaign is ran, an exception will be then raised). must have the format (Y-m-d H:i:s)</dd>
 * <dt>baseUrl</dt>
 * <dd>a localized value of the base url to use for e-mail links</dd>
 * <dt>subject</dt>
 * <dd>a localized value of the subject line of the e-mail (default, can be overwritten by a specific choice variant localized parameters with parameter name 'subject')</dd>
 * <dt>firstSentence</dt>
 * <dd>a localized value of the first sentence of the e-mail (default, can be overwritten by a specific choice variant localized parameters with parameter name 'firstSentence')</dd>
 * <dt>legals</dt>
 * <dd>a localized value of the legal notices to be included in the e-mail (default, can be extended by a specific choice variant localized parameters with parameter name 'legals')</dd>
 * </dl>
 */
struct EmailCampaign {
	1: required string emailCampaignId
	2: required string cmpid
	3: required string dateTime
	4: required map<Language,string> baseUrl
	5: required map<Language,string> subject
	6: required map<Language,string> firstSentence
	7: required map<Language,string> legals
}

/**
 * This structure defines a data Choice.
 * <dl>
 * <dt>choiceId</dt>
 * <dd>a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters</dd>
 * </dl>
 */
struct Choice {
	1: required string choiceId
}

/**
 * This structure defines a data Choice variant
 * <dl>
 * <dt>choiceVariantId</dt>
 * <dd>a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters</dd>
 * <dt>choiceId</dt>
 * <dd>the choice id of the choice which this variant is associated to</dd>
 * <dt>tags</dt>
 * <dd>a list of tags this variant is connected to</dd>
 * <dt>simpleParameters</dt>
 * <dd>a list of non-localized parameters this variant is connected to (for example, to overwrite the campaign properties, keys should have the same name as the campaign parameter name)</dd>
 * <dt>localizedParemeters</dt>
 * <dd>a list of localized parameters this variant is connected to (for example, to overwrite the campaign properties, keys should have the same name as the campaign parameter name)</dd>
 * </dl>
 */
struct ChoiceVariant {
	1: required string choiceVariantId,
	2: required string choiceId,
	3: required list<string> tags,
	4: required map<string, list<string>> simpleParameters,
	5: required map<string, list<map<Language,string>>> localizedParemeters
}

/**
 * This enumeration defines the possible process task execution statuses type (to check the completion of an execution of  process task and its result)
 *
 * <dl>
 * <dt>WAITING</dt>
 * <dd>The process was not started yet</dd>
 *
 * <dt>STARTED</dt>
 * <dd>The process has started and is currently running</dd>
 * </dl>
 *
 * <dt>STARTED</dt>
 * <dd>The process has started and is currently running</dd>
 * </dl>
 *
 * <dt>FINISHED_SUCCESS</dt>
 * <dd>The process has finished successfully</dd>
 * </dl>
 *
 * <dt>FINISHED_WITH_WARNINGS</dt>
 * <dd>The process has finished, but with some warnings</dd>
 * </dl>
 *
 * <dt>FAILED</dt>
 * <dd>The process has failed</dd>
 * </dl>
 *
 * <dt>ABORTED</dt>
 * <dd>The process has been aborted</dd>
 * </dl>
 */
enum ProcessTaskExecutionStatusType {
	WAITING = 1,
	STARTED = 2,
	FINISHED_SUCCESS = 3,
	FINISHED_WITH_WARNINGS = 4,
	FAILED = 5,
	ABORTED = 6,
}

/**
 * This structure defines a process task execution status (the status of execution of a process task) with its type and a textual message
 *
 * <dl>
 * <dt>statusType</dt>
 * <dd>the status type of this execution of the process task</dd>
 * <dt>information</dt>
 * <dd>some additonal information about the type (can be empty, used to explain errors and warnings)</dd>
 * </dl>
 */
struct ProcessTaskExecutionStatus {
	1: required ProcessTaskExecutionStatusType statusType,
	2: required string information
}

/**
 * This structure defines the execution parameters of a process task
 *
 * <dl>
 * <dt>processTaskId</dt>
 * <dd>the process task id to execute</dd>
 * <dt>development</dt>
 * <dd>should the process run with development data that should not to be published into the production environment</dd>
 * <dt>delta</dt>
 * <dd>is the process a differential process that adds or updates a part of the existing data, otherwise the new data will replace any existing data completely</dd>
 * <dt>forceStart</dt>
 * <dd>if another similar process is already running, the forceStart flag will make the new one run, otherwise, the execution will be aborted</dd>
 * </dl>
 */
struct ProcessTaskExecutionParameters {
	1: required string processTaskId,
	2: required bool development,
	3: required bool delta,
	4: required bool forceStart
}

/**
 * This enumeration defines possible types of columns which can be used in a reference CSV file
 *
 * <dl>
 *
 * <dt>STRING</dt>
 * <dd>text string encoded using UTF-8 encoding</dd>
 * 
 * <dt>INTEGER</dt>
 * <dd>64-bit signed integer</dd>
 * 
 * <dt>DOUBLE</dt>
 * <dd>floating point number</dd>
 * 
 * <dt>DATETIME</dt>
 * <dd>textual representation of the date and time</dd>
 * 
 * <dt>DATE</dt>
 * <dd>textual representation of the date</dd>
 * 
 * <dt>TIME</dt>
 * <dd>textual representation of the time</dd>
 * 
 * <dt>UNIX_TIMESTAMP</dt>
 * <dd>numerical representation of the date and time</dd>
 *
 * </dl>
 */
enum CSVFileColumnType {
	STRING = 1,
	INTEGER = 2,
	DOUBLE = 3,
	DATETIME = 4,
	DATE = 5,
	TIME = 6,
	UNIX_TIMESTAMP = 7
}

/**
 * This structure defines a reference CSV file descriptor with the identifier and schema
 *
 * <dl>
 * <dt>fileId</dt>
 * <dd>identifier of the csv file, needs to be unique per account</dd>
 * <dt>fileColumns</dt>
 * <dd>key-value map of the file columns, where key is a name of the column and value is a column's type</dd>
 * <dt>fileHash</dt>
 * <dd>internal hash used for csv file upload - this property is set by the API and cannot be changed</dd>
 * </dl>
 */
struct ReferenceCSVFileDescriptor {
	1: required string fileId,
	2: required map<string, CSVFileColumnType> fileColumns,
	3: optional string fileHash
}

/**
 * This structure defines a schedulings execution parameters. A scheduling is a collection of process tasks to be executed one after the other by the system.
 *
 * <dl>
 * <dt>schedulingId</dt>
 * <dd>the scheduling id to execute</dd>
 * <dt>development</dt>
 * <dd>should the process tasks run with development version data</dd>
 * <dt>delta</dt>
 * <dd>are the process tasks incremental processes (or full)</dd>
 * <dt>forceStart</dt>
 * <dd>if similar process tasks are already running, the forceStart will make the new ones run, otherwise, the execution will be aborted</dd>
 * </dl>
 */
struct SchedulingExecutionParameters {
	1: required string schedulingId,
	2: required bool development,
	3: required bool delta,
	4: required bool forceStart
}

/**
 * This structure defines a time range
 *
 * <dl>
 * <dt>from</dt>
 * <dd>UNIX timestamp of a lower boundary of the range</dd>
 * <dt>to</dt>
 * <dd>UNIX timestamp of a upper boundary of the range</dd>
 * </dl>
 */
struct TimeRange {
	1: required i64 from,
	2: required i64 to
}

/**
 * This enumeration defines possible granularities used in time ranges
 *
 * <dl>
 * <dt>DAY</dt>
 * <dd>daily precision</dd>
 * <dt>WEEK</dt>
 * <dd>weekly precision</dd>
 * <dt>MONTH</dt>
 * <dd>monthly precision</dd>
 * </dl>
 */
enum TimeRangePrecision {
	DAY = 1,
	WEEK = 2,
	MONTH = 3
}

/**
 * This structure defines a time range value of the KPI
 * 
 * <dl>
 * <dt>range</dt>
 * <dd>used time range</dd>
 * <dt>value</dt>
 * <dd>KPI value for this particular range</dd>
 * </dl>
 */
struct TimeRangeValue {
	1: required TimeRange range,
	2: required double value
}

service BoxalinoDataIntelligence {
/**
 * this service function returns a new authentication token
 *
 * <dl>
 * <dt>@param authentication</dt>
 * <dd>a fully complete AuthenticationRequest with the content of your credentials</dd>
 * <dt>@return</dt>
 * <dd>an Authentication object with your new authentication token (valid for 1 hour)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_CREDENTIALS:if the provided account / username / password information don't match the records of Boxalino system.</dd>
 * <dd>BLOCKED_USER:if the provided user has been blocked.</dd>
 * <dd>BLOCKED_ACCOUNT:if the provided account has been blocked.</dd>
 * </dl>
 */
	Authentication GetAuthentication(1: AuthenticationRequest authentication) throws (1: DataIntelligenceServiceException e),
	
	
/**
 * this service function changes the current password
 *
 * <dl>
 * <dt>@param authentication</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param newPassword</dt>
 * <dd>the new password to replace the existing one (careful, no forgot the new password, if you lose your password, contact <ahref="mailto:support@boxalino.com">support@boxalino.com</a></dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_NEW_PASSWORD:if the provided new password is not properly formatted (should be at least 8 characters long and not contain any punctuation).</dd>
 * </dl>
 */
	void UpdatePassword(1:	Authentication authentication, 2: string newPassword) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function returns the configuration version object matching the provided versionType. In general, you should always ask for the CURRENT_DEVELOPMENT_VERSION, unless you want to access directly (at your own risks) the production configuration.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN: if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dt>@returns ConfigurationVersion</dt>
 * <dd>The configuration object to use in your calls to other service functions which access your configuration parameters</dd>
 * </dl>
 */
	ConfigurationVersion GetConfigurationVersion(1: Authentication authentication, 2: ConfigurationVersionType versionType) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function udpates your data source configuration.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param dataSourcesConfigurationXML</dt>
 * <dd>the data source XML must follow the strict XML format and content as defined in the Boxalino documentation. This XML defines the way the system must extract data from the various files (typically a list of CSV files compressed in a zip file) to synchronize your product, customers and transactions data (tracker data are direclty provided to Boxalino Javascript tracker and are there not part of the data to be synchronized here. Please make sure that the product id is defined in a coherent way between he product files, the transaction files and the tracker (product View, add to basket and purchase event) (so the mapping can be done); same comment for the customer id: between the customer files, the transaction files and the tracker (set user event). If you don't have the full documentation of the data source XML, please contact <a href="mailto:support@boxalino.com">support@boxalino.com</a></dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>INVALID_DATASOURCE:if the provided new data source XML string doesn't match the required format (see documentation of the data source XML format)</dd>
 * <dt>@Nota Bene</dt>
 * <dd>If you remove fields definition from your data source, they will not be automatically deleted. You need to explicitely delte them through the delete component service function to remove them.</dd>
 * </dl>
 */
	void SetDataSourcesConfiguration(1: Authentication authentication, 2: ConfigurationVersion configurationVersion, 3: string dataSourcesConfigurationXML) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function returns the map of all the defined field (key = fieldId, value = Field object).
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dt>@returns map<string, Field></dt>
 * <dd>A map containing all the defined fields of your account in this configuration version, with the fieldId as key and the Field object as value (key is provided for accessibility only, as the field id is also present in the Field object</dd>
 * </dl>
 */
	map<string, Field> GetFields(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function creates a new field 
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param fieldId</dt>
 * <dd>the field id to be created (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID:if the provided field id already exists.</dd>
 * <dd>INVALID_CONTENT_ID:if the provided field id format is not valid.</dd>
 * </dl>
 */
	void CreateField(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string fieldId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function updates a field 
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param field</dt>
 * <dd>a Field object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided field id doesn't already exists.</dd>
 * <dd>INVALID_CONTENT:if the provided field content is not valid.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateField(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: Field field) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function deletes a field
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param fieldId</dt>
 * <dd>the field id to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided field id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteField(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string fieldId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function returns the map of all the defined process tasks (key = processTaskId, value = ProcessTask object).
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dt>@returns map<string, ProcessTask></dt>
 * <dd>A map containing all the defined process tasks of your account in this configuration version, with the processTaskId as key and the ProcessTask object as value (key is provided for accessibility only, as the processTaskId is also present in the ProcessTask object</dd>
 * </dl>
 */
	map<string, ProcessTask> GetProcessTasks(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function creates a new process task 
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param processTaskId</dt>
 * <dd>the process task id to be created (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID:if the provided process task id already exists.</dd>
 * <dd>INVALID_CONTENT_ID:if the provided process task id format is not valid.</dd>
 * </dl>
 */
	void CreateProcessTask(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string processTaskId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function updates a process task 
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param processTask</dt>
 * <dd>a ProcessTask object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided process task id doesn't already exists.</dd>
 * <dd>INVALID_CONTENT:if the provided process task content is not valid.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateProcessTask(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: ProcessTask processTask) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function deletes a process task
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param processTaskId</dt>
 * <dd>the process task id to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided process task id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteProcessTask(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string processTaskId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function executes a process task
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param processTaskId</dt>
 * <dd>the process task id to be executed</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided process task id doesn't already exists.</dd>
 * <dt>@return process id</dt>
 * <dd>the processs task execution id of this process task execution (to be used to get an updated status through GetProcessStatus)</dd>
 * </dl>
 */
	string RunProcessTask(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: ProcessTaskExecutionParameters parameters) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function returns the map of all the defined email campaigns (key = emailCampaignId, value = EmailCampaign object).
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dt>@returns map<string, EmailCampaign></dt>
 * <dd>A map containing all the defined email campaigns of your account in this configuration version, with the emailCampaignId as key and the EmailCampaign object as value (key is provided for accessibility only, as the emailCampaignId is also present in the EmailCampaign object</dd>
 * </dl>
 */
	map<string, EmailCampaign> GetEmailCampaigns(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function creates a new email campaign. a campaign is something permanent , so you shouldn't create one for each sending of a newsletter (but instead update the cmpid parameter of a permanent campaign e.g.: 'newsletter')
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param emailCampaignId</dt>
 * <dd>the email campaign id to be created (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID:if the provided email campaign id already exists.</dd>
 * <dd>INVALID_CONTENT_ID:if the provided email campaign id format is not valid.</dd>
 * </dl>
 */
	void CreateEmailCampaign(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string emailCampaignId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function updates a email campaign 
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param emailCampaign</dt>
 * <dd>a EmailCampaign object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided email campaign id doesn't already exists.</dd>
 * <dd>INVALID_CONTENT:if the provided email campaign content is not valid.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateEmailCampaign(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: EmailCampaign emailCampaign) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function deletes a email campaign
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param emailCampaignId</dt>
 * <dd>the email campaign id to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided email campaign id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteEmailCampaign(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string emailCampaignId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function returns the map of all the defined choices (key = choiceId, value = Choice object).
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param choiceSourceId</dt>
 * <dd>the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dt>@returns map<string, Choice></dt>
 * <dd>A map containing all the defined choices of your account in this configuration version, with the choiceId as key and the Choice object as value (key is provided for accessibility only, as the choiceId is also present in the Choice object</dd>
 * </dl>
 */
	map<string, Choice> GetChoices(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string choiceSourceId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function creates a new choice
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dd>the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@param choiceId</dt>
 * <dd>the choice id to be created (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID:if the provided choice id already exists.</dd>
 * <dd>INVALID_CONTENT_ID:if the provided choice id format is not valid.</dd>
 * </dl>
 */
	void CreateChoice(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string choiceSourceId, 4: string choiceId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function updates a choice 
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dd>the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@param choice</dt>
 * <dd>a Choice object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided choice id doesn't already exists.</dd>
 * <dd>INVALID_CONTENT:if the provided choice content is not valid.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateChoice(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string choiceSourceId, 4: Choice choice) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function deletes a choice
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dd>the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@param choiceId</dt>
 * <dd>the choice id to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided choice id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteChoice(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string choiceSourceId, 4: string choiceId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function returns the map of all the defined choices (key = choiceId, value = Choice object).
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dd>the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@param choiceId</dt>
 * <dd>the choice id on which to get the choice variants from</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided choice id doesn't already exists.</dd>
 * <dt>@returns map<string, Choice></dt>
 * <dd>A map containing all the defined choice variants of your account in this configuration version and for this specific choice, with the choiceVariantId as key and the ChoiceVariant object as value (key is provided for accessibility only, as the choiceVariantId is also present in the ChoiceVariant object</dd>
 * </dl>
 */
	map<string, ChoiceVariant> GetChoiceVariants(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string choiceSourceId, 4: string choiceId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function creates a new choice
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dd>the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@param choiceId</dt>
 * <dd>the choice id on which to create a new choice variant (must exists)</dd>
 * <dt>@param choiceVariantId</dt>
 * <dd>the choice variant id to be created (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided choice id doesn't already exists.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID:if the provided choice variant id already exists.</dd>
 * <dd>INVALID_CONTENT_ID:if the provided choice variant id format is not valid.</dd>
 * </dl>
 */
	void CreateChoiceVariant(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string choiceSourceId, 4: string choiceId, 5: string choiceVariantId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function updates a choice 
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dd>the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@param choiceVariant</dt>
 * <dd>a ChoiceVariant object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided choice variant id doesn't already exists.</dd>
 * <dd>INVALID_CONTENT:if the provided choice variant content is not valid.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateChoiceVariant(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string choiceSourceId, 4: ChoiceVariant choiceVariant) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function deletes a choice
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dd>the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@param choiceId</dt>
 * <dd>the choice id on which to delete the choice variant id</dd>
 * <dt>@param choiceId</dt>
 * <dd>the choice variant id to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided choice or choice variant id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteChoiceVariant(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string choiceSourceId, 4: string choiceId, 5: string choiceVariantId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function retrieves a process status
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param processTaskExecutionId</dt>
 * <dd>the process task execution status id to retrieve the status of</dd>
 * <dt>@return process task execution status</dt>
 * <dd>the current status of this process task execution id</dd>
 * </dl>
 */
	ProcessTaskExecutionStatus GetProcessStatus(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string processTaskExecutionId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service retrieves the list of configuration changes between two versions (typically between dev and prod versions)
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersionSource</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion) to be considered as the source (typically the version returned by GetConfigurationVersion with the ConfigurationVersionType CURRENT_DEVELOPMENT_VERSION)</dd>
 * <dt>@param configurationVersionDestination</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion) to be considered as the destination (typically the  version returned by GetConfigurationVersion with the ConfigurationVersionType CURRENT_PRODUCTION_VERSION)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if one of provided configuration versions is not valid.</dd>
 * </dl>
 */
	list<ConfigurationDifference> GetConfigurationDifferences(1: Authentication authentication, 2: ConfigurationVersion configurationVersionSource, 3: ConfigurationVersion configurationVersionDestination) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service retrieves publishes the provided configuration version. The result is that this configuration will become the CURRENT_PRODUCTION_VERSION version and will be used automatically by all running processes. Also, as a consequence, a copy of the provided configuration version will be done and will become the new CURRENT_DEVELOPMENT_VERSION.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * </dl>
 */
	void PublishConfiguration(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service copies the provided configuration version. The result is that this new configuration will become the CURRENT_DEVELOPMENT_VERSION.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * </dl>
 */
	void CloneConfiguration(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),

/**
 * This service is responsible for reference csv file creation. It allows to configure csv schema which will be imported as fields in DI.
 * File should be uploaded as an attachement to the POST HTTP request sent to the following URL:
 *      http://di1.bx-cloud.com/frontend/dbmind/_/en/dbmind/api/reference/csv/file/upload?iframeAccount={account}&fileHash={ReferenceCSVFileDescriptor.fileHash}
 * File hash is set by the API internally and cannot be changed.
 *
 * <dl>
 * <dt>@param authentication</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configuration</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param fileDescriptor</dt>
 * <dd>a ReferenceCSVFileDescriptor object describing the file that we want to create</dd>
 * <dt>@return</dt>
 * <dd>updated copy of ReferenceCSVFileDescriptor object describing the created file, with the file hash set</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>DUPLICATED_FILE_ID: if the given file identifier already exists</dd>
 * <dd>EMPTY_COLUMNS_LIST: if the given columns list is empty</dd>
 * </dl>
 */
	ReferenceCSVFileDescriptor CreateReferenceCSVFile(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: ReferenceCSVFileDescriptor fileDescriptor) throws (1: DataIntelligenceServiceException e),

/**
 * This service is responsible for updating reference csv file.
 *
 * <dl>
 * <dt>@param authentication</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configuration</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param fileDescriptor</dt>
 * <dd>an updated ReferenceCSVFileDescriptor object</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN: if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>EMPTY_COLUMNS_LIST: if the given columns list is empty</dd>
 * <dd>NON_EXISTING_FILE: if the file does not exist</dd>
 * </dl>
 */
	void UpdateReferenceCSVFile(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: ReferenceCSVFileDescriptor fileDescriptor) throws (1: DataIntelligenceServiceException e),

/**
 * This service is responsible for reference csv file removal.
 *
 * <dl>
 * <dt>@param authentication</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configuration</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param fileDescriptor</dt>
 * <dd>the ReferenceCSVFileDescriptor object to be removed</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN: if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_FILE: if the file does not exist</dd>
 * </dl>
 */
	void DeleteReferenceCSVFile(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: ReferenceCSVFileDescriptor fileDescriptor) throws (1: DataIntelligenceServiceException e),


/**
 * This service is responsible for reference csv file removal.
 *
 * <dl>
 * <dt>@param authentication</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configuration</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param fileDescriptor</dt>
 * <dd>the ReferenceCSVFileDescriptor object to be removed</dd>
 * <dt>@return</dt>
 * <dd>list of all reference csv files assigned to the current account</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN: if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * </dl>
 */
	list<ReferenceCSVFileDescriptor> GetAllReferenceCSVFiles(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),


/**
 * this service function creates additional fields
 *
 * <dl>
 * <dt>@param authentication</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configuration</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param fieldsConfigurationXML</dt>
 * <dd>the fields configuration XML must follow the strict XML format and content as defined in the Boxalino documentation. This XML described fields which have to be created by parsing existing reference csv file.</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>INVALID_DATASOURCE_XML:if the provided new data source XML string doesn't match the required format (see documentation of the data source XML format)</dd>
 * </dl>
 */
	void CreateFieldsFromReferenceCSVFile(1: Authentication authentication, 2: ConfigurationVersion configurationVersion, 3: string fieldsConfigurationXML) throws (1: DataIntelligenceServiceException e),

/**
 * this service function returns the map of all the defined schedulings (key = schedulingId, value = Scheduling object).
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dt>@returns map<string, Scheduling></dt>
 * <dd>A map containing all the defined schedulings of your account in this configuration version, with the schedulingId as key and the Scheduling object as value (key is provided for accessibility only, as the schedulingId is also present in the Scheduling object</dd>
 * </dl>
 */
	map<string, Scheduling> GetSchedulings(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function creates a new scheduling. A scheduling is a collection of process tasks to be executed one after the other by the system.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param schedulingId</dt>
 * <dd>the scheduling id to be created (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID:if the provided  scheduling id already exists.</dd>
 * <dd>INVALID_CONTENT_ID:if the provided scheduling id format is not valid.</dd>
 * </dl>
 */
	void CreateScheduling(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string schedulingId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function updates a scheduling. A scheduling is a collection of process tasks to be executed one after the other by the system.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param scheduling</dt>
 * <dd>a Scheduling object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided Scheduling id doesn't already exists.</dd>
 * <dd>INVALID_CONTENT:if the provided Scheduling content is not valid.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateScheduling(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: Scheduling scheduling) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function deletes a scheduling. A scheduling is a collection of process tasks to be executed one after the other by the system.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param schedulingId</dt>
 * <dd>the schedulingId to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided schedulingId id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteScheduling(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string schedulingId) throws (1: DataIntelligenceServiceException e),

/**
 * this service function executes a scheduling. A scheduling is a collection of process tasks to be executed one after the other by the system.
 *
 * <dl>
 * <dt>@param authentication</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configuration</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param parameters</dt>
 * <dd>parameters describing the scheduling which we want to execute</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided scheduling id doesn't already exists.</dd>
 * </dl>
 */
	void RunScheduling(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: SchedulingExecutionParameters parameters) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function returns the map of all the defined recommendation blocks (key = recommendationBlockId, value = RecommendationBlock object).
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dt>@returns map<string, RecommendationBlock></dt>
 * <dd>A map containing all the defined RecommendationBlocks of your account in this configuration version, with the RecommendationBlock id as key and the RecommendationBlock object as value (key is provided for accessibility only, as the RecommendationBlock id is also present in the RecommendationBlock object</dd>
 * </dl>
 */
	map<string, RecommendationBlock> GetRecommendationBlocks(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function creates a new RecommendationBlock. A RecommendationBlock is a visual block of recommendation for one page of your web-site (product detail page, basket page, etc.) you can have several recommendation blocks on the same page.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param recommendationBlockId</dt>
 * <dd>the recommendation block id to be created (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID:if the provided  recommendationBlock id already exists.</dd>
 * <dd>INVALID_CONTENT_ID:if the provided recommendationBlock id format is not valid.</dd>
 * </dl>
 */
	void CreateRecommendationBlock(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string recommendationBlockId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function updates a RecommendationBlock. A RecommendationBlock is a visual block of recommendation for one page of your web-site (product detail page, basket page, etc.) you can have several recommendation blocks on the same page.
 * 
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param recommendationBlock</dt>
 * <dd>a recommendationBlock object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided RecommendationBlock id doesn't already exists.</dd>
 * <dd>INVALID_CONTENT:if the provided RecommendationBlock content is not valid.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateRecommendationBlock(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: RecommendationBlock recommendationBlock) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function deletes a RecommendationBlock. A RecommendationBlock is a visual block of recommendation for one page of your web-site (product detail page, basket page, etc.) you can have several recommendation blocks on the same page.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param recommendationBlockId</dt>
 * <dd>the recommendationBlockId to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided recommendationBlockId id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteRecommendationBlock(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string recommendationBlockId) throws (1: DataIntelligenceServiceException e),

	map<string, DataSource> GetDataSources(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),

	void CreateDataSource(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string dataSourceId) throws (1: DataIntelligenceServiceException e),

	void UpdateDataSource(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: DataSource dataSource) throws (1: DataIntelligenceServiceException e),

	void DeleteDataSource(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string dataSourceId) throws (1: DataIntelligenceServiceException e),

	map<string, DataExport> GetDataExports(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),

	void CreateDataExport(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string dataExportId) throws (1: DataIntelligenceServiceException e),

	void UpdateDataExport(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: DataExport dataExport) throws (1: DataIntelligenceServiceException e),

	void DeleteDataExport(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string dataExportId) throws (1: DataIntelligenceServiceException e),

	map<string, ReferenceCSVDataSource> GetReferenceCSVFileDataSources(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),

	void CreateReferenceCSVDataSource(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string dataSourceId) throws (1: DataIntelligenceServiceException e),

	void UpdateReferenceCSVDataSource(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: ReferenceCSVDataSource dataSource) throws (1: DataIntelligenceServiceException e),

	void DeleteReferenceCSVDataSource(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string dataSourceId) throws (1: DataIntelligenceServiceException e),
	
/**
 * This service function gets an identifier of last imported transaction. It can be useful for differential data synchronization.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@returns string</dt>
 * <dd>an identifier of the last transaction</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * </dl>
 */
        string GetLastTransactionID(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),

/**
 * This service function retrieves number of visits for each time range with selected precision.
 * 
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param range</dt>
 * <dd>a time range of generated reports</dd>
 * <dt>@param precision</dt>
 * <dd>a level of granularity</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>INVALID_RANGE: if the given time range is incorrect</dd>
 * </dl>
 */
	list<TimeRangeValue> GetPageViews(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: TimeRange range, 4: TimeRangePrecision precision) throws (1: DataIntelligenceServiceException e),

}
