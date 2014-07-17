From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: tcflow(TCOON/TCOOFF) vs. received XON/XOFF characters
Date: Thu, 17 Jul 2014 14:18:32 -0400
Message-ID: <53C81378.60606@hurleysoftware.com>
References: <lq6c9q$isi$1@ger.gmane.org> <53C7CB1B.3010804@hurleysoftware.com> <lq8l35$cfa$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:56945 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751339AbaGQSSe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Jul 2014 14:18:34 -0400
In-Reply-To: <lq8l35$cfa$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>, linux-serial@vger.kernel.org

On 07/17/2014 10:03 AM, Grant Edwards wrote:
> On 2014-07-17, Peter Hurley <peter@hurleysoftware.com> wrote:
>
>> tcflow(TCOxxx) flow control is independent of IXON flow control.
>> The union of both flow states determines if the tty can output;
>>
>>                        IXON = true        IXON = false
>>                     START       STOP
>> tcflow(TCOON)      on         off          on
>> tcflow(TCOOFF)     off        off          off
>
> Thanks, that's pretty much what I had decided based on tests and
> browsing the source code.
>
> Just to confirm:
>
>    tcflow(TCION/TCIOFF): overrides the "input" side of xon/xoff flow
>                          control and forces the sending of XON/XOFF.
>
>    tcflow(TCOON/TCOOFF): does not have anything to do with the "output"
>                          side of xon/xoff flow control, but controls
>                          something completely orthogonal.
>
> That rather counter-intuitive (not that counter-intuitive is exactly a
> novel thing when it comes to Unix serial ports).
>
> That rasies this question: what does an application use to control the
> "output" side of xon/xoff flow control?  There is a Windows API for
> doing that, and I get asked how to do it in Linux.  I always tell them
> they can't.

I didn't explain this properly.

Both tcflow(TCOxxx) and receiving START/STOP when IXON == true control
the output flow.

For example,

     ttyS0 = open("/dev/ttyS0", O_RDWR);

     /* Disable ttyS0 output */
     tcflow(ttyS0, TCOOFF);

     /* writes to ttyS0 will now be buffered but not sent */

     /* remote terminal sends START which is received, however sending is
      * still disabled by tcflow()
      */

     /* Enable ttyS0 output */
     tcflow(ttyS0, TCOON);

     /* ttyS0 output enabled, previously buffered writes are now sent */

     /* remote terminal sends STOP which is received and ttyS0 output
      * is now disabled (writes to ttyS0 will be buffered but not sent)
      */

     tcflow(ttyS0, TCOON);  <--- has no effect because flow was not previously
                                 disabled by tcflow()

     /* remote terminal sends START which is received and ttyS0 output
      * is now enabled, previously buffered writes are now sent
      */


I did gloss over one special case:  tcflow(TCOON) will re-enable output
_even if the remote terminal last sent STOP_ but only if output is also
disabled by tcflow(TCOOFF).

To me, the separate state tracking of tcflow() and START/STOP makes sense.

Regards,
Peter Hurley


