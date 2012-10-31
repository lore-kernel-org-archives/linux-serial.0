From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: New serial card development
Date: Wed, 31 Oct 2012 16:55:56 -0500
Message-ID: <CAJp1Oe7Lk2q6v+5jrj2wD4cW=M9LX6kkia=AQnJKOiUEod5uRQ@mail.gmail.com>
References: <5074703E.408@commtech-fastcom.com> <20121014093704.GA6207@thunk.org>
 <CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
 <20121016002608.64b33de5@pyramind.ukuu.org.uk> <20121016023226.GA17446@thunk.org>
 <CAJp1Oe4n-TtxDM8D82bFQxjBtx8rSAX8mWrFk0bSM6uGL9X=Eg@mail.gmail.com>
 <20121019212158.GB4721@thunk.org> <CAJp1Oe6ekkaZ29iwJ91VXwM_CSL6Z0_KEaqVQTa1XMzTB5niEQ@mail.gmail.com>
 <CAJp1Oe67Jd+FaaDPosexrVrrUFS=c-0FUZx_JHTbpTN5RCCcUw@mail.gmail.com>
 <20121023183859.GA3317@kroah.com> <CAJp1Oe7MMuk8TNBom2EDXx6UBdMV6qAE5fDdKTZ0o-329QSdaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:54246 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760596Ab2JaV4R (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 31 Oct 2012 17:56:17 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so2059786vbb.19
        for <linux-serial@vger.kernel.org>; Wed, 31 Oct 2012 14:56:16 -0700 (PDT)
In-Reply-To: <CAJp1Oe7MMuk8TNBom2EDXx6UBdMV6qAE5fDdKTZ0o-329QSdaA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Mon, Oct 29, 2012 at 3:04 PM, Matt Schulte
<matts@commtech-fastcom.com> wrote:
> On Tue, Oct 23, 2012 at 1:38 PM, Greg KH <greg@kroah.com> wrote:
>> On Tue, Oct 23, 2012 at 11:31:41AM -0500, Matt Schulte wrote:
>>> On Tue, Oct 23, 2012 at 11:27 AM, Matt Schulte
>>> <matts@commtech-fastcom.com> wrote:
>>> > On Fri, Oct 19, 2012 at 4:21 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>>> >> Alan's advice to get your card working as a basic serial card is very
>>> >> good one.  Get basic functionality working, and then you can add the
>>> >> support for the extra bits later....
>>> >
>>> > I can see the logic in getting it working as a basic serial card
>>> > first.  I think at minimum I would still need to implement the extra
>>> > divisor calculations to get accurate bit rates.
>>> >
>>> > So when it works as a basic serial card, I assume you would want me to
>>> > use the default PCI IDs to keep it more generic.  Then would I add my
>>> > own PCI IDs and refer them back to the generic port?
>>> >
>
> I am working to get the Exar devices added to the 8250 driver.  I
> think I get most of what I need to make happen until I get to the
> detection of the EFR register.  Can someone explain to me what is
> going on here and where the Exar device is supposed to end up?  It
> seems to me that I would expect them to show up somewhere around :
>
> /*
>  * Exar uarts have EFR in a weird location
>  */
>
> But instead I am getting my UARTs detected as EFRv1, iir=3 and marked
> as type=ST16650.
>
> For reference the Exar chips have EFR located at an address of 1001
> (UART_XR_EFR).  There isn't anything special that has to be done to
> access this location, just look at 1001.

I was able to work my way through the funky EFR detection.  Hopefully
you guys will like what I did when you see the patch.

Next I need to know the channel number of a given UART port.  If I
have a 4 port UART I need to know that a given channel is 0,1,2 or 3.
If I have an 8 port UART I need to know if a given channel is
0,1,2,3,4,5,6 or 7.

The only way that I can find to get this number is using the idx
variable that is passed to the port's .setup operation.  Would I be
able to add a member to the uart_port structure so that I could store
this number inside my UARTs setup function?

Something like:

struct uart_port {
.
.
.
unsigned int channel;
};

pci_myuart_setup(struct serial_private *priv,
                const struct pciserial_board *board,
                struct uart_8250_port *port, int idx)
{
...
        port->port.channel = idx;
        return pci_default_setup(priv, board, port, idx);
}

Thank you,
Matt Schulte
