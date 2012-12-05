From: Will Fagan <willf@commtech-fastcom.com>
Subject: Re: [PATCH 2/2] The correct device id for this card is 0x0022.
Date: Wed, 5 Dec 2012 16:20:56 -0600
Message-ID: <CAGyNnbh=HLcfscSMjEX=zjzXPbETEmSkzLGAu7kxuEkG9eY0Ow@mail.gmail.com>
References: <1354740983-4352-1-git-send-email-matts@commtech-fastcom.com>
 <1354740983-4352-2-git-send-email-matts@commtech-fastcom.com> <20121205213812.42c61b2e@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38255 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab2LEWVR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Dec 2012 17:21:17 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so9141107ieb.19
        for <linux-serial@vger.kernel.org>; Wed, 05 Dec 2012 14:21:17 -0800 (PST)
In-Reply-To: <20121205213812.42c61b2e@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matt Schulte <matts_old@commtech-fastcom.com>, linux-serial@vger.kernel.org, greg@kroah.com, Matt Schulte <matts@commtech-fastcom.com>

I just spoke with Matt. He isn't by his email and asked if he only
needed to resend the patch with the reordering or both patches?

Will
Commtech, Inc.
Voice: 316-636-1131
Fax: 316-636-1163
http://www.commtech-fastcom.com



On Wed, Dec 5, 2012 at 3:38 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Wed,  5 Dec 2012 14:56:22 -0600
> Matt Schulte <matts_old@commtech-fastcom.com> wrote:
>
> > Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
> > ---
> > Built against tty-next commit: b0ab02361167faa82198b783a8d555eb6f58901c
> >
> >  drivers/tty/serial/8250/8250_pci.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> > index bf2f1a0..777832c 100644
> > --- a/drivers/tty/serial/8250/8250_pci.c
> > +++ b/drivers/tty/serial/8250/8250_pci.c
> > @@ -1301,7 +1301,7 @@ pci_wch_ch353_setup(struct serial_private *priv,
> >  #define PCI_VENDOR_ID_AGESTAR                0x5372
> >  #define PCI_DEVICE_ID_AGESTAR_9375   0x6872
> >  #define PCI_VENDOR_ID_ASIX           0x9710
> > -#define PCI_DEVICE_ID_COMMTECH_4222PCIE 0x0019
> > +#define PCI_DEVICE_ID_COMMTECH_4222PCIE 0x0022
> >  #define PCI_DEVICE_ID_COMMTECH_4224PCIE      0x0020
> >  #define PCI_DEVICE_ID_COMMTECH_4228PCIE      0x0021
>
> Can you keep them in order 8)
>

On Wed, Dec 5, 2012 at 3:38 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Wed,  5 Dec 2012 14:56:22 -0600
> Matt Schulte <matts_old@commtech-fastcom.com> wrote:
>
>> Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
>> ---
>> Built against tty-next commit: b0ab02361167faa82198b783a8d555eb6f58901c
>>
>>  drivers/tty/serial/8250/8250_pci.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
>> index bf2f1a0..777832c 100644
>> --- a/drivers/tty/serial/8250/8250_pci.c
>> +++ b/drivers/tty/serial/8250/8250_pci.c
>> @@ -1301,7 +1301,7 @@ pci_wch_ch353_setup(struct serial_private *priv,
>>  #define PCI_VENDOR_ID_AGESTAR                0x5372
>>  #define PCI_DEVICE_ID_AGESTAR_9375   0x6872
>>  #define PCI_VENDOR_ID_ASIX           0x9710
>> -#define PCI_DEVICE_ID_COMMTECH_4222PCIE 0x0019
>> +#define PCI_DEVICE_ID_COMMTECH_4222PCIE 0x0022
>>  #define PCI_DEVICE_ID_COMMTECH_4224PCIE      0x0020
>>  #define PCI_DEVICE_ID_COMMTECH_4228PCIE      0x0021
>
> Can you keep them in order 8)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
William Fagan
Commtech, Inc.
Voice: 316-636-1131
Fax: 316-636-1163
http://www.commtech-fastcom.com
