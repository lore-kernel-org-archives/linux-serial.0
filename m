From: Angelo Butti <buttiangelo@gmail.com>
Subject: Re: Pericom PCIe Serial board Support (12d8:7952/4/8) - Chip PI7C9X7952/4/8
Date: Tue, 15 Oct 2013 22:41:10 +0300
Message-ID: <525D9A56.9080402@gmail.com>
References: <CAO5Y4f2pszuzTYewAwzJ91BHeoNeSJsMynscyY7CjFTspeaYzg@mail.gmail.com> <CAO5Y4f0jtcZP2ScWxt2X7On3W1PzuvZnMG3+2uZ5puvrFbmMvA@mail.gmail.com> <20131015140903.GA20755@kroah.com> <CAO5Y4f1Em-WG9Yk41OUmJQCdZo2N=eDXK+R+wq0K4BxoNGoaug@mail.gmail.com> <20131015172801.GA27279@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:40680 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759629Ab3JOTns (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Oct 2013 15:43:48 -0400
Received: by mail-ee0-f53.google.com with SMTP id t10so499898eei.26
        for <linux-serial@vger.kernel.org>; Tue, 15 Oct 2013 12:43:47 -0700 (PDT)
In-Reply-To: <20131015172801.GA27279@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 10/15/2013 08:28 PM, Greg KH wrote:
> On Tue, Oct 15, 2013 at 07:20:18PM +0200, Angelo Butti wrote:
>> I'm really sorry for my mistake.
>
> No worries, but your email client turned all tabs into spaces, and made
> the patch imposible to apply :(
>
>> Also, maybe that there is a simple way to change the clock without
>> rewrite the standard serial setup procedure, but I cannot find it ....
>> Below the correct one:
>>
>> --- linux-3.10.11-200.fc19.i686/drivers/tty/serial/8250/8250_pci.c.orig
>> 2013-09-16 20:13:52.918548000 +0300
>> +++ linux-3.10.11-200.fc19.i686/drivers/tty/serial/8250/8250_pci.c
>> 2013-10-15 16:20:18.566685996 +0300
>> @@ -1308,6 +1308,29 @@ static int pci_default_setup(struct seri
>>    return setup_port(priv, port, bar, offset, board->reg_shift);
>>   }
>>
>> +static int pci_pericom_setup(struct serial_private *priv,
>> +  const struct pciserial_board *board,
>> +  struct uart_8250_port *port, int idx)
>
> See?
>
> Also, we need a "Signed-off-by:" line as per the instructions in the
> Documentation/SubmittingPatches file (take a look at it for what that
> means.)
>
> Care to try again?
>
> thanks,
>
> greg k-h
>

Ok, I change the email client .... I hope ....

Signed-off-by: Angelo Butti <buttiangelo@gmail.com>

Regards,
Angelo


--- linux-3.10.11-200.fc19.i686/drivers/tty/serial/8250/8250_pci.c.orig 
2013-09-16 20:13:52.918548000 +0300
+++ linux-3.10.11-200.fc19.i686/drivers/tty/serial/8250/8250_pci.c 
2013-10-15 16:20:18.566685996 +0300
@@ -1308,6 +1308,29 @@ static int pci_default_setup(struct seri
  	return setup_port(priv, port, bar, offset, board->reg_shift);
  }

+static int pci_pericom_setup(struct serial_private *priv,
+		  const struct pciserial_board *board,
+		  struct uart_8250_port *port, int idx)
+{
+	unsigned int bar, offset = board->first_offset, maxnr;
+
+	bar = FL_GET_BASE(board->flags);
+	if (board->flags & FL_BASE_BARS)
+		bar += idx;
+	else
+		offset += idx * board->uart_offset;
+
+	maxnr = (pci_resource_len(priv->dev, bar) - board->first_offset) >>
+		(board->reg_shift + 3);
+
+	if (board->flags & FL_REGION_SZ_CAP && idx >= maxnr)
+		return 1;
+
+	port->port.uartclk = 14745600;
+
+	return setup_port(priv, port, bar, offset, board->reg_shift);
+}
+
  static int
  ce4100_serial_setup(struct serial_private *priv,
  		  const struct pciserial_board *board,
@@ -1825,6 +1848,31 @@ static struct pci_serial_quirk pci_seria
  		.exit		= pci_plx9050_exit,
  	},
  	/*
+	 * Pericom
+	 */
+	{
+		.vendor		= 0x12d8,
+		.device		= 0x7952,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
+	},		
+	{
+		.vendor		= 0x12d8,
+		.device		= 0x7954,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
+	},		
+	{
+		.vendor		= 0x12d8,
+		.device		= 0x7958,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
+	},		
+
+	/*
  	 * PLX
  	 */
  	{

