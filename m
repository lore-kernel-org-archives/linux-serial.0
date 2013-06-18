From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 0/5] MIPS/tty/8250: Use standard 8250 drivers for OCTEON
Date: Tue, 18 Jun 2013 12:59:28 -0700
Message-ID: <51C0BC20.2070501@caviumnetworks.com>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com> <20130618193618.GA1401@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130618193618.GA1401@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org, Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
List-Id: linux-serial@vger.kernel.org

On 06/18/2013 12:36 PM, Ralf Baechle wrote:
> On Tue, Jun 18, 2013 at 12:12:50PM -0700, David Daney wrote:
>
>> From: David Daney <david.daney@cavium.com>
>>
>> Get rid of the custom OCTEON UART probe code and use 8250_dw instead.
>>
>> The first patch just gets rid of Ralf's Kconfig workarounds for the
>> real problem, which is OCTEON's inclomplete serial support.
>>
>> Then we just make minor patches to 8250_dw, and rip out all this
>> OCTEON code.
>>
>> Since the patches are all interdependent, we might want to merge them
>> via a single tree (perhaps Ralf's MIPS tree).
>
> Looks good - I was trying to come up with a kludge good enough for 3.10;
> this may be a bit too large ...
>

At this point I think it is fine if some random configs for OCTEON fail 
to build in v3.10.

I was thinking that this would be for 3.11


David Daney
