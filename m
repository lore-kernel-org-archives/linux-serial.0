From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v1 3/4] max3100: adds console support for MAX3100
Date: Wed, 31 Mar 2010 00:04:44 -0600
Message-ID: <v2mfa686aa41003302304rd966efe0k204d78aef793f75c@mail.gmail.com>
References: <1269340105-6503-1-git-send-email-chripell@fsfe.org>
	<1269340170-6558-1-git-send-email-chripell@fsfe.org> <20100329104838.49c18075@feng-i7>
	<cabda6421003282311x78051e1eq38ada68f2553609e@mail.gmail.com>
	<20100329150642.4a94e78a@feng-i7> <cabda6421003290555k70d13168y4beba2c3ae6e2ece@mail.gmail.com>
	<20100330101445.5c64dedb@feng-i7> <cabda6421003292349m2dd6125cp2bcc1060f5aa8741@mail.gmail.com>
	<20100330094637.325d3fb9@lxorguk.ukuu.org.uk> <cabda6421003300503t4fc7d3c4tc51167611180fef9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53969 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932357Ab0CaGFF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 31 Mar 2010 02:05:05 -0400
Received: by gwaa18 with SMTP id a18so5201223gwa.19
        for <linux-serial@vger.kernel.org>; Tue, 30 Mar 2010 23:05:04 -0700 (PDT)
In-Reply-To: <cabda6421003300503t4fc7d3c4tc51167611180fef9@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: christian pellegrin <chripell@fsfe.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Feng Tang <feng.tang@intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "greg@kroah.com" <greg@kroah.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tue, Mar 30, 2010 at 6:03 AM, christian pellegrin <chripell@fsfe.org> wrote:
> On Tue, Mar 30, 2010 at 10:46 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>
>> There I would partly disagree. Fixing the spi driver clearly makes sense
>> but the serial driver should be batching better. Is there a reason the
>> driver couldn't adjust the size based upon the tty speed when getting a
>> termios request ?
>
> Just a small note for those who don't know max31x0. There are just 2
> instructions to tx/rx data: simple data rx (in which we read one data
> from the fifo (the data is valid if R status bit is set), control
> lines (CTS) and status bits) and a combined tx/rx (like before but we
> also send one byte (if the T status bit the char will be accepted) and
> set control lines (RTS)). Every of these instructions is 2 bytes long.
> It's a full SPI message (so you have to assert CS before and de-assert
> it afterwards to make it work). TX buffer is just 1 byte deep, RX one
> is 8 bytes.

Is checking the T bit really necessary if Linux instead tracks the
timing between bytes internally?  ie.  If the driver uses an hrtimer
to schedule the submission of SPI transfers such that the time between
SPI submissions is always greater than the time required for a serial
character to be transmitted?

You may be able to set this up into a free-running state machine.
Submit the SPI transfers asynchronously, and use a callback to be
notified when the transfer is completed.  In most cases, the transfer
will be completed every time, but if it is not, then the state machine
can just wait another time period before submitting.  By doing it this
way, all the work can be handled at the atomic context without any
workqueues or threaded IRQ handlers.

Here's some draft )completely untested and uncompiled) code for the
bottom half:  The time rate would be calculated when the baud rate is
set.  I've glossed over a bunch of details and corner cases, but you
get the idea...

void max3100_spi_complete(void *__max3100)
{
  struct max3100_port *max3100 = __max3100;
  spin_lock(&max3100->lock);
  max3100->busy = 0;
  /* Process received characters here.  Schedule a workqueue if
needed.  A ring buffer would probably work well. */
  spin_unlock(&max3100->lock);
}

enum hrtimer_restart max3100_hrtimer_callback( struct hrtimer *timer )
{
  struct max3100_port *max3100 = container_of(timer, struct
max3100_port, hrtimer);

  if (max3100->busy)
    return HRTIMER_RESTART; /* still busy, try again later */

  spin_lock(&max3100->lock);
  /* The following 7 lines can probably actually be done once at
driver probe time */
  spi_message_init(&max3100->spi_msg);
  spi_message_add_tail(&max3100->spi_tran);
  max3100->spi_tran.tx_buf = mac3100->tx_buf;
  max3100->spi_tran.rx_buf = mac3100->rx_buf;
  max3100->spi_tran.len = 2;  /* can this be larger to receive
multiple bytes in 1 transfer? */
  max3100->spi_msg.complete = max3100_spi_complete;
  max3100->spi_msg.context = max3100;
  /* Alternately, a bunch of transfers could be queued up with only
the first actual
   * containing tx data.  The rest would be for RX */

  if (&max3100->tx_pending) {
    /* a ring buffer may be a better idea here */
    max3100->tx_buf[0] = max3100->tx_pending_data;
    max3100->tx_pending = 0;
  }
  spi_async(&max3100->spi_msg);
  max3100->busy = 1;  /* cleared by the completion callback */

  spin_unlock(&max3100->lock);

  return HRTIMER_RESTART;
}

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
