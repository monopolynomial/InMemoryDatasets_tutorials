
using DLMReader
import Downloads
temp_downloaded_file=Downloads.download("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
covid=filereader(temp_downloaded_file,quotechar='"',guessingrows=5)
covid_time_series=transpose(groupby(covid,[1,2,3,4]),Not([1,2,3,4]),renamerowid=x->Date(x,dateformat"m/d/y")+Year(2000),variable_name="Date",renamecolid=x->"Confirmed")
