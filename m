From: Angelo Butti <buttiangelo@gmail.com>
Subject: Re: Pericom PCIe Serial board Support (12d8:7952/4/8) - Chip PI7C9X7952/4/8
Date: Tue, 15 Oct 2013 19:20:18 +0200
Message-ID: <CAO5Y4f1Em-WG9Yk41OUmJQCdZo2N=eDXK+R+wq0K4BxoNGoaug@mail.gmail.com>
References: <CAO5Y4f2pszuzTYewAwzJ91BHeoNeSJsMynscyY7CjFTspeaYzg@mail.gmail.com>
	<CAO5Y4f0jtcZP2ScWxt2X7On3W1PzuvZnMG3+2uZ5puvrFbmMvA@mail.gmail.com>
	<20131015140903.GA20755@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f54.google.com ([209.85.212.54]:54640 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932317Ab3JORUT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Oct 2013 13:20:19 -0400
Received: by mail-vb0-f54.google.com with SMTP id q14so5248206vbe.41
        for <linux-serial@vger.kernel.org>; Tue, 15 Oct 2013 10:20:19 -0700 (PDT)
In-Reply-To: <20131015140903.GA20755@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I'm really sorry for my mistake.
Also, maybe that there is a simple way to change the clock without
rewrite the standard serial setup procedure, but I cannot find it ....
Below the correct one:

--- linux-3.10.11-200.fc19.i686/drivers/tty/serial/8250/8250_pci.c.orig
2013-09-16 20:13:52.918548000 +0300
+++ linux-3.10.11-200.fc19.i686/drivers/tty/serial/8250/8250_pci.c
2013-10-15 16:20:18.566685996 +0300
@@ -1308,6 +1308,29 @@ static int pci_default_setup(struct seri
  return setup_port(priv, port, bar, offset, board->reg_shift);
 }

+static int pci_pericom_setup(struct serial_private *priv,
+  const struct pciserial_board *board,
+  struct uart_8250_port *port, int idx)
+{
+ unsigned int bar, offset = board->first_offset, maxnr;
+
+ bar = FL_GET_BASE(board->flags);
+ if (board->flags & FL_BASE_BARS)
+ bar += idx;
+ else
+ offset += idx * board->uart_offset;
+
+ maxnr = (pci_resource_len(priv->dev, bar) - board->first_offset) >>
+ (board->reg_shift + 3);
+
+ if (board->flags & FL_REGION_SZ_CAP && idx >= maxnr)
+ return 1;
+
+ port->port.uartclk = 14745600;
+
+ return setup_port(priv, port, bar, offset, board->reg_shift);
+}
+
 static int
 ce4100_serial_setup(struct serial_private *priv,
   const struct pciserial_board *board,
@@ -1825,6 +1848,31 @@ static struct pci_serial_quirk pci_seria
  .exit = pci_plx9050_exit,
  },
  /*
+ * Pericom
+ */
+ {
+ .vendor = 0x12d8,
+ .device = 0x7952,
+ .subvendor = PCI_ANY_ID,
+ .subdevice = PCI_ANY_ID,
+ .setup = pci_pericom_setup,
+ },
+ {
+ .vendor = 0x12d8,
+ .device = 0x7954,
+ .subvendor = PCI_ANY_ID,
+ .subdevice = PCI_ANY_ID,
+ .setup = pci_pericom_setup,
+ },
+ {
+ .vendor = 0x12d8,
+ .device = 0x7958,
+ .subvendor = PCI_ANY_ID,
+ .subdevice = PCI_ANY_ID,
+ .setup = pci_pericom_setup,
+ },
+
+ /*
  * PLX
  */
  {

2013/10/15 Greg KH <gregkh@linuxfoundation.org>:
> On Tue, Oct 15, 2013 at 03:48:55PM +0200, Angelo Butti wrote:
>> Hi all,
>> I'm here again to try to solve and add support to Pericom serial devices.
>>
>> To solve is really simple, but I don't know if I make the correct
>> procedure. The solution is change the clock value from 1.8432 to
>> 14.7456.
>> To do this I add a new setup specific for pericom devices, and I add
>> this 3 devices inside the Master list of serial port.
>>
>> Now, is possible add this to the standard linux kernel, so also the
>> Pericom device will be ok ?
>>
>> Below the patch for the 3.10.11 kernel ....
>
> Can you generate the patch with 'diff -u' so that it is in a format that
> I can apply it to the kernel tree?  Specifics on how to create the
> patch, and what you need to include in it is in the
> Documentation/SubmittingPatches file.
>
> If you have any problems or questions after reading that file, please
> let us know.
>
> thanks,
>
> greg k-h
