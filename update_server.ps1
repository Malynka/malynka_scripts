cd $(Get-ChildItem -Path "D:\\" -Recurse -Directory -Filter malynka_be | Select-Object -First 1 -ExpandProperty FullName)
git pull
pnpm build