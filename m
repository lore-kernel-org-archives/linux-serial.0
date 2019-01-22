From: Guan Yung Tseng <guan.yung.tseng@ni.com>
Subject: [PATCH v2] 8250_pci.c: Update NI specific devices class to multi serial
Date: Tue, 22 Jan 2019 17:19:42 +0800
Message-ID: <1548148782-3414-1-git-send-email-guan.yung.tseng@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, hch@infradead.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Guan Yung Tseng <guan.yung.tseng@ni.com>
List-Id: linux-serial@vger.kernel.org

On, Jan 14, 2019 at 10:10:05PM +0800, Guan Yung Tseng wrote:
>> Modified NI devices class to PCI_CLASS_COMMUNICATION_MULTISERIAL.
>> The reason of doing this is because all NI multi port serial cards
>> use PCI_CLASS_COMMUNICATION_OTHER class and thus fail the
>> serial_pci_is_class_communication test added in the commit 7d8905d06405
>> ("serial: 8250_pci: Enable device after we check black list").
>> 
>> Signed-off-by: Guan Yung Tseng <guan.yung.tseng@ni.com>
>> ---
>>  drivers/tty/serial/8250/8250_pci.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>> 
>> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
>> index 4986b4a..0949db1 100644
>> --- a/drivers/tty/serial/8250/8250_pci.c
>> +++ b/drivers/tty/serial/8250/8250_pci.c
>> @@ -663,6 +663,13 @@ static int pci_xircom_init(struct pci_dev *dev)
>>  	return 0;
>>  }
>>  
>> +static int pci_ni_probe(struct pci_dev *dev)
>> +{
>> +	dev->class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8 |
>> +			(dev->class & 0xff);

>
> As Christoph said, this looks really odd.  This field comes from the
> PCI structure on the device, it should not be modified by the kernel.
> 
> Unless the device is broken and needs to be fixed up in the kernel?
> 
> Also, you have sent 2 different patches here for this type of issue, are
> both needed?  If so, please resend both of them as a patch series, with
> more explainations in this one as to why you are modifying this field.
> 
> I've dropped all pending patches from you from my queue now.
> 

Hi Christoph and Greg,

Sorry for the confusion sending 2 different patches to solve the same
issue. I should have wait for your response before sending antoher
patch to solve the similar issue.

For some historical reason, NI serial devices use
PCI_CLASS_COMMUNICATION_OTHER class code. Yes, I understand that
the class code should read from config space instead modified from
kernel. But these devices are shipped to the market for many years.
That's why I am trying to fix the problem in the kernel.

I will send another simple patch again to fix the problem.
