// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50100 ItemListExt extends "Item List"
{
    actions
    {
        addlast(reporting)
        {
            action(PrintLabel)
            {
                Image = BarCode;
                ApplicationArea = All;
                Caption = 'Print Label';

                trigger OnAction()
                var
                    DirPrtQueue: Record "ForNAV DirPrt Queue";
                    Base64Convert: Codeunit "Base64 Convert";
                    tempBlob: Codeunit "Temp Blob";
                    base64, zpl : Text;
                    zplInStream: InStream;
                    zplOutStream: OutStream;
                // bt: BigText;
                begin
                    // Get Zebra language from stored base64 string
                    base64 := 'Q1R+fkNELH5DQ15+Q1R+Cl5YQX5UQTAwMH5KU05eTFQwXk1OV15NVEReUE9OXlBNTl5MSDAsMF5KTUFeUFI1LDV+U0QxNV5KVVNeTFJOXkNJMF5YWgpeWEEKXk1NVApeUFc2MDkKXkxMMDQwNgpeTFMwCl5CWTQsMyw4NF5GVDEwMiwxOTleQkNOLCxZLE4KXkZEPjp7Tk99XkZTCl5GVDEwMiw4MF5BME4sMjgsMjheRkhcXkZEe0RFU0NSSVBUSU9OfV5GUwpeUFExLDAsMSxZXlha';
                    zpl := Base64Convert.FromBase64(base64);

                    // Replace the placeholders with the real data
                    zpl := zpl.Replace('{NO}', Rec."No.").Replace('{DESCRIPTION}', Rec.Description);

                    // bt.AddText(zpl);
                    // tempBlob.CreateOutStream(os);
                    // bt.Write(os);
                    // tempBlob.CreateInStream(is);

                    // Create an InStream with the Zebra language
                    tempBlob.CreateOutStream(zplOutStream);
                    zplOutStream.WriteText(zpl);
                    tempBlob.CreateInStream(zplInStream);

                    // Create a print job on the print queue
                    DirPrtQueue.Create('Item Label', 'Zebra Demo', zplInStream, DirPrtQueue.ContentType::Zebra);
                end;
            }
        }
    }
}