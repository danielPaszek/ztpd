(:5. doc("db/bib/bib.xml")/bib/book/author/last :)
(:
<wynik>
{
  for $a in doc("db/bib/bib.xml")//bib/book/author
return <ksiazka>
  <author>{$a/last/text() ||' '|| $a/first/text()}</author>
  {$a/../title}
</ksiazka>
}
</wynik>
:)
(:10.
<imiona>
{
  for $a in doc("db/bib/bib.xml")//bib/book/author
where $a/../title = 'Data on the Web'
return 
  <imie>{$a/first/text()}</imie>
}
</imiona>
:)
(:11.
for $a in doc("db/bib/bib.xml")//bib/book
where $a/title='Data on the Web'
return <DataOnTheWeb>
{$a}
</DataOnTheWeb>
11.2
for $a in doc("db/bib/bib.xml")//bib/book[title='Data on the Web']
return <DataOnTheWeb>
{$a}
</DataOnTheWeb>
:)
(:13
for $a in doc("db/bib/bib.xml")//bib/book[contains(title, 'Data')]
return <Data>{$a/title} 
  {for $b in $a//author 
  return <nawisko>{$b/last/text()}</nawisko>
}
</Data>
:)
(:14
for $a in doc("db/bib/bib.xml")//bib/book
where count($a/author) <= 2
return $a/title
:)
(:15
for $a in doc("db/bib/bib.xml")//bib/book
return <ksiazka>
  {$a/title}
  <autorow>{count($a/author)}</autorow>
</ksiazka>
16.
for $a in doc("db/bib/bib.xml")//bib
return <przedzial>{min($a/book/@year) || ' - ' || max($a/book/@year)}</przedzial>
17.
for $a in doc("db/bib/bib.xml")//bib
return <roznica>{max($a/book/price) - min($a/book/price)}</roznica>
:)
<najtansze>{
for $a in doc("db/bib/bib.xml")//bib
return <roznica>{max($a/book/price) - min($a/book/price)}</roznica>

}</najtansze>




