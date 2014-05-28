From: Prasad Koya <prasad.koya@gmail.com>
Subject: Re: UART_IIR_BUSY set for 16550A
Date: Tue, 27 May 2014 22:47:05 -0700
Message-ID: <CAGXD9OdyXxpVZVR44N-ZKe5Nwz9EVbH_YgZncVbskRfsAq6Htw@mail.gmail.com>
References: <CAGXD9Ocoo_sUnFmd-pfU52yUQ5oPjWxAHXjvP8facuMiOSUn5w@mail.gmail.com>
	<20140525003642.GC6946@thunk.org>
	<CAGXD9Odvyd_go-x9-gR7Q7_etYPLHekDM3SKRN+PCvDHc__LHg@mail.gmail.com>
	<20140525024414.GF6946@thunk.org>
	<CAGXD9Of8-v9TJ-0uuQ3TDzo5QYhB3uA=B5kMGQkiABSzFrWDng@mail.gmail.com>
	<20140525120409.GG6946@thunk.org>
	<CAGXD9OcNT6m+HUJU=E9-DB-UwBVd1Pz_EmcQDzTwou0i7ayKQg@mail.gmail.com>
	<20140528050339.GA18258@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:33916 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbaE1FrG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 May 2014 01:47:06 -0400
Received: by mail-ve0-f178.google.com with SMTP id sa20so12103818veb.9
        for <linux-serial@vger.kernel.org>; Tue, 27 May 2014 22:47:05 -0700 (PDT)
In-Reply-To: <20140528050339.GA18258@thunk.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org

Hi Ted,

this UART is from intel board. here is the data sheet i referred to earlier:

http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/intel-communications-chipset-89xx-series-datasheet.pdf

we ship AMD based boards as well that has integrated UART but we
haven't seen this on AMD boards.

yes, the code i am talking about could be something like this that
should get enabled in last resort:

if ( pass_counter == (PASS_LIMIT - 1) ) {
      if ( iir == 0xcc and ! (status & UART_LSR_DR) ) {
          status |= UART_LSR_DR;
      }
}

and let it fall through:

        if (status & (UART_LSR_DR | UART_LSR_BI)) {
                status = serial8250_rx_chars(up, status);
        }

if character received is garbage i'm thinking it should be caught in
our test scripts.

its hacky. i am trying to be optimistic, give that a try and see if helps.

if char received is garbage then as you hinted it must be that
transmit ready interrupt that is not getting set. in the first
iteration of this interrupt handling (at the random time where it
eventually hits PASS_LIMIT), LSR is 0x21 and it always received 2
chars and sent 1 char. this has been consistent in all occurrences of
the bug.

when this happens i'm also wondering if 'stty' can help in resetting the UART.

thanks again.



On Tue, May 27, 2014 at 10:03 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Tue, May 27, 2014 at 04:33:58PM -0700, Prasad Koya wrote:
>>
>> From what I understand, there is a character in recv FIFO and no other
>> characters have been received in last 4 chars time. So why wouldn't
>> that set UART_LSR_DR?
>>
>> #define UART_LSR_DR             0x01 /* Receiver data ready */
>
> It is supposed to set UART_LSR_DR.  But your own debugging printk's
> have shown that it doesn't in some cases.  Hence my assertion that you
> have a buggy UART.
>
>> If my understanding is correct and there is a byte in recv FIFO to be
>> read, why isn't the driver coded to pick up that byte if IIR is 0xcc.
>> maybe not all 16550A compatible UARTs don't do this and thats why its
>> left out?
>
> The problem is you have to sample UART_LSR_DR to determine when the
> FIFO is empty, because just because the receive interrupt bit is set
> in the IIR, you don't know how many characters are in the Receive
> FIFO.  So you have to trust the UART_LSR_DR to tell you when the
> receive FIFO is empty.
>
> Now, I suppose you could check to see if the first time through the
> loop, if UART_LSR_DR is clear, maybe you should try anyway, but that
> means adding a lot of extra complexity that historically has never
> been needed.
>
> What UART is this, and is there some way we can shame the manufacturer
> into fixing it?  It would be a shame to have to put in even more hair
> just for one outlier.  Now, if some major manufacturer is shippping
> huge numbers of buggy UART's, maybe we should work around it --- but
> at this point, I think it would be useful to understand who the guilty
> party might be, and whether this is a systemic problem, or whether
> your specific chip is buggy.
>
> In general, making chages to the uart core is always fragile, because
> a workaround for one buggy manufacturer could introduce problems for
> other buggy UARTs....
>
>> Infact, if i type a char on console and let it go idle, I'm seeing IIR
>> register as 0xCC and LSR as 0x61. Since bit 0 of LSR is set, that byte
>> is getting picked up. So I wonder why at a random time, UART sets IIR
>> as 0xCC and leaves LSR as 0 and LSR becomes 0x60 after about 350
>> iterations in that loop and stays that way. For a buggy UART like
>> that, sounds like one could use that condition as exception to go
>> ahead and read the receive buffer. What do you say?
>
> The other question is we don't know whether it's the IIR which is
> buggy, or the DR bit which is buggy.  Maybe the receive FIFO really is
> empty, but it's the transmit interrupt which is stuck.  So we don't
> know whether the right thing to do is to read from the RX register and
> put it into the buffer.  It could be that might not do anything, and
> just cause a stream of null's, or garbage, or the last character read
> from the FIFO to be jam up the incoming tty receive buffer.
>
> So if you were going to implement something which says, "ignore the DR
> bit being clear, just read from the FIFO anyway, because the IIR tells
> me so, there had better be some limiter where if the IIR doesn't
> change even after you try reading from the receive buffer, at some
> point you really do want to give up."
>
> Basically, the best way to program the serial driver is very
> defensively.  Assume that the UART firmware is written by monkeys, and
> malicious monkeys at that.  Because sooner or later, you will come
> across some UART which really is crappier than you know or can imagine....
>
> Cheers,
>
>                                                 - Ted
