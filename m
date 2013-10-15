From: Angelo Butti <buttiangelo@gmail.com>
Subject: Re: Pericom PCIe Serial board Support (12d8:7952/4/8) - Chip PI7C9X7952/4/8
Date: Tue, 15 Oct 2013 15:48:55 +0200
Message-ID: <CAO5Y4f0jtcZP2ScWxt2X7On3W1PzuvZnMG3+2uZ5puvrFbmMvA@mail.gmail.com>
References: <CAO5Y4f2pszuzTYewAwzJ91BHeoNeSJsMynscyY7CjFTspeaYzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169]:41520 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759121Ab3JONs4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Oct 2013 09:48:56 -0400
Received: by mail-ve0-f169.google.com with SMTP id oy12so691746veb.14
        for <linux-serial@vger.kernel.org>; Tue, 15 Oct 2013 06:48:55 -0700 (PDT)
In-Reply-To: <CAO5Y4f2pszuzTYewAwzJ91BHeoNeSJsMynscyY7CjFTspeaYzg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi all,
I'm here again to try to solve and add support to Pericom serial devices.

To solve is really simple, but I don't know if I make the correct
procedure. The solution is change the clock value from 1.8432 to
14.7456.
To do this I add a new setup specific for pericom devices, and I add
this 3 devices inside the Master list of serial port.

Now, is possible add this to the standard linux kernel, so also the
Pericom device will be ok ?

Below the patch for the 3.10.11 kernel ....

1311,1333d1310
< static int pci_pericom_setup(struct serial_private *priv,
<  const struct pciserial_board *board,
<  struct uart_8250_port *port, int idx)
< {
< unsigned int bar, offset = board->first_offset, maxnr;
<
< bar = FL_GET_BASE(board->flags);
< if (board->flags & FL_BASE_BARS)
< bar += idx;
< else
< offset += idx * board->uart_offset;
<
< maxnr = (pci_resource_len(priv->dev, bar) - board->first_offset) >>
< (board->reg_shift + 3);
<
< if (board->flags & FL_REGION_SZ_CAP && idx >= maxnr)
< return 1;
<
< port->port.uartclk = 14745600;
<
< return setup_port(priv, port, bar, offset, board->reg_shift);
< }
<
1850,1874d1826
< /*
< * Pericom
< */
< {
< .vendor = 0x12d8,
< .device = 0x7952,
< .subvendor = PCI_ANY_ID,
< .subdevice = PCI_ANY_ID,
< .setup = pci_pericom_setup,
< },
< {
< .vendor = 0x12d8,
< .device = 0x7954,
< .subvendor = PCI_ANY_ID,
< .subdevice = PCI_ANY_ID,
< .setup = pci_pericom_setup,
< },
< {
< .vendor = 0x12d8,
< .device = 0x7958,
< .subvendor = PCI_ANY_ID,
< .subdevice = PCI_ANY_ID,
< .setup = pci_pericom_setup,
< },
<

Regards,
Angelo

2013/6/26 Angelo Butti <buttiangelo@alice.it>:
> Hi all,
> my name is Angelo and I have a problem with some Pericom Serial boards.
> This hardware is compatible to 16C550 but is not working good.
>
> Now I can workaround the problem, I understand it but I'm not able to make some
> patch for the serial driver inside the linux kernel. So, now I want
> try to explain the
> problems and if you can adjust the driver also for this device will be
> great; or if you can
> explain me with some example how I can do it and send to you the patch .....
>
> Anyway, the problem is related to Pericom serial boards, pci-id:
> 12d8:7952 (2 serials)
> 12d8:7954 (4 serials)
> 12d8:7958 (8 serials)
>
> The first problem is related to the kind of the serial ports. This
> hardware can be
> 232-422-4852W-4854W mode, and must be set inside the PCI express
> registers at the offset b4h.
> For example if you have a 2 serial port 485-2W board, before use it
> you must set that
> register to 0xFF ( I make this with setpci command and all is ok)
>
> Te second problem, more critical for me, is the bps setting. The board
> that I want use have
> on board a 14.7456 Mhz, and there are a table inside datasheet with
> the configuration example
> and the formula to set proper bps settings. The problem is related to
> the standard linux driver that use the clock equal to  1.8432 MHz.
> So every time that I open the serial, this bps isn't correct. I must
> adjust it writing inside the registers (after open) to fix the
> problem.
> Is possible add this kind of board inside the standard linux driver to
> have a good bps setting ?
>
> En example, to set 115200bps:
> Standard linux driver: DLL:0x1 DLH:0x0
> Pericom formula: DLL:0x8 DLH:0x0
>
> (Ref. PI7C9X7952/4/8 (Datasheet))
>
> Thanks, best regards
> Angelo
