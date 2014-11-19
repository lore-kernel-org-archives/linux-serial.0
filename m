From: Peter Hung <hpeter@gmail.com>
Subject: Re: [PATCH] Fix IO address calculation with Multi-Fintek PCI-to-UART
 Product
Date: Wed, 19 Nov 2014 13:42:36 +0800
Message-ID: <546C2DCC.4090507@gmail.com>
References: <1416304088-6049-1-git-send-email-hpeter+linux_kernel@gmail.com> <20141118165800.GA3708@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:60038 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaKSFmk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Nov 2014 00:42:40 -0500
In-Reply-To: <20141118165800.GA3708@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Dear Greg KH and Senior Linuxers,

I had some some question, If I submited a patch, but it had rejected,=20
how should I do when fix the patch?

1. send patch by reply original email ?
2. direct send patch with new email again?
3. other ways ?

Live long and prosper
Thanks

Greg KH =E6=96=BC 2014/11/19 =E4=B8=8A=E5=8D=88 12:58 =E5=AF=AB=E9=81=93=
:
> On Tue, Nov 18, 2014 at 05:48:08PM +0800, Peter Hung wrote:
>> Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
>
> We need some kind of information in the body of the changelog here.
>
>> ---
>>   drivers/tty/serial/8250/8250_pci.c | 37 ++++++++++++++++++++++++--=
-----------
>>   1 file changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial=
/8250/8250_pci.c
>> index 0468e15..255bc56 100644
>> --- a/drivers/tty/serial/8250/8250_pci.c
>> +++ b/drivers/tty/serial/8250/8250_pci.c
>> @@ -1551,28 +1551,31 @@ static int pci_fintek_setup(struct serial_pr=
ivate *priv,
>>   {
>>   	struct pci_dev *pdev =3D priv->dev;
>>   	unsigned long base;
>> -	unsigned long iobase;
>> +	unsigned long iobase =3D 0;
>>   	unsigned long ciobase =3D 0;
>>   	u8 config_base;
>> +	u32 bar_data[3];
>> +=09
>>
>
> _ALWAYS_ run your patches through checkpatch.pl and fix up the issues=
 it
> reports so that a grumpy maintainer doesn't reject your patch for
> obvious issues :(
>
>
>
>>   	/*
>>   	 * We are supposed to be able to read these from the PCI config s=
pace,
>>   	 * but the values there don't seem to match what we need to use, =
so
>>   	 * just use these hard-coded values for now, as they are correct.
>>   	 */
>> +
>>   	switch (idx) {
>> -	case 0: iobase =3D 0xe000; config_base =3D 0x40; break;
>> -	case 1: iobase =3D 0xe008; config_base =3D 0x48; break;
>> -	case 2: iobase =3D 0xe010; config_base =3D 0x50; break;
>> -	case 3: iobase =3D 0xe018; config_base =3D 0x58; break;
>> -	case 4: iobase =3D 0xe020; config_base =3D 0x60; break;
>> -	case 5: iobase =3D 0xe028; config_base =3D 0x68; break;
>> -	case 6: iobase =3D 0xe030; config_base =3D 0x70; break;
>> -	case 7: iobase =3D 0xe038; config_base =3D 0x78; break;
>> -	case 8: iobase =3D 0xe040; config_base =3D 0x80; break;
>> -	case 9: iobase =3D 0xe048; config_base =3D 0x88; break;
>> -	case 10: iobase =3D 0xe050; config_base =3D 0x90; break;
>> -	case 11: iobase =3D 0xe058; config_base =3D 0x98; break;
>> +	case 0: config_base =3D 0x40; break;
>> +	case 1: config_base =3D 0x48; break;
>> +	case 2: config_base =3D 0x50; break;
>> +	case 3: config_base =3D 0x58; break;
>> +	case 4: config_base =3D 0x60; break;
>> +	case 5: config_base =3D 0x68; break;
>> +	case 6: config_base =3D 0x70; break;
>> +	case 7: config_base =3D 0x78; break;
>> +	case 8: config_base =3D 0x80; break;
>> +	case 9: config_base =3D 0x88; break;
>> +	case 10: config_base =3D 0x90; break;
>> +	case 11: config_base =3D 0x98; break;
>>   	default:
>>   		/* Unknown number of ports, get out of here */
>>   		return -EINVAL;
>> @@ -1583,9 +1586,17 @@ static int pci_fintek_setup(struct serial_pri=
vate *priv,
>>   		ciobase =3D (int)(base + (0x8 * idx));
>>   	}
>>
>> +	pci_read_config_dword(pdev, 0x24, &bar_data[0]);
>> +	pci_read_config_dword(pdev, 0x20, &bar_data[1]);
>> +	pci_read_config_dword(pdev, 0x1c, &bar_data[2]);
>> +
>> +	/* Calculate Real IO Port */
>> +	iobase =3D (bar_data[idx/4] & 0xffffffE0) + (idx % 4) * 8;
>> +
>>   	dev_dbg(&pdev->dev, "%s: idx=3D%d iobase=3D0x%lx ciobase=3D0x%lx =
config_base=3D0x%2x\n",
>>   		__func__, idx, iobase, ciobase, config_base);
>>
>> +
>
> New line added for no reason?
>
> thanks,
>
> greg k-h
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
