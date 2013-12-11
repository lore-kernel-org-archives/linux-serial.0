From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [PATCH] serial: 8250_dw: Fix LCR workaround regression
Date: Wed, 11 Dec 2013 13:00:33 -0800
Message-ID: <CAAYSxhr10XqQdQrvGf3Ez6e4LSbvmc0J-=yRgUePVEcd93e5wQ@mail.gmail.com>
References: <1386714484-30251-1-git-send-email-james@albanarts.com>
	<20131211140014.GF28456@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131211140014.GF28456@xps8300>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: James Hogan <james@albanarts.com>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>, James Hogan <james.hogan@imgtec.com>, Jiri Slaby <jslaby@suse.cz>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Matt Porter <matt.porter@linaro.org>, Markus Mayer <markus.mayer@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Dec 11, 2013 at 6:00 AM, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> Hi,
>
> On Tue, Dec 10, 2013 at 10:28:04PM +0000, James Hogan wrote:
>> From: James Hogan <james.hogan@imgtec.com>
>>
>> Commit c49436b657d0 (serial: 8250_dw: Improve unwritable LCR workaround)
>> caused a regression. It added a check that the LCR was written properly
>> to detect and workaround the busy quirk, but the behaviour of bit 5
>> (UART_LCR_SPAR) differs between IP versions 3.00a and 3.14c per the
>> docs. On older versions this caused the check to fail and it would
>> repeatedly force idle and rewrite the LCR register, causing delays and
>> preventing any input from serial being received.
>>
>> This is fixed by masking out UART_LCR_SPAR before making the comparison.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jiri Slaby <jslaby@suse.cz>
>> Cc: Tim Kryger <tim.kryger@linaro.org>
>> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>> Cc: Matt Porter <matt.porter@linaro.org>
>> Cc: Markus Mayer <markus.mayer@linaro.org>
>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Tested-by: Tim Kryger <tim.kryger@linaro.org>
>> Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>
> I tested this with HW without the busy functionality
> (UART_16550_COMPATIBLE == yes). No problems here. FWIW:
>
> Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Greg, can you consider taking this patch as a regression fix for 3.13?

Just in case you want a little more background beyond what is in the
commit message...

Statically declared DW UARTs will execute autoconfig_16550a during
probe which attempts to set the SPAR bit of LCR.  Some old versions of
the DW IP don't implement the stick parity feature and for these
versions the SPAR bit always reads back as zero. Since these writes
aren't fully accepted by the hardware, they trigger the workaround
which interprets the partially rejected write to mean the UART was
busy.  A number of attempts are made to idle the UART and re-write the
LCR but eventually the workaround gives up and prints a warning.  DT
declared DW UARTs don't run autoconfig and don't see this issue as far
as I know.

Thanks,
Tim Kryger
