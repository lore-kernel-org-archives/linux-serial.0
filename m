From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] serial: 8250: Prevent kernel crash with nr_uarts=0
Date: Mon, 04 May 2015 19:45:48 +0200
Message-ID: <5547B04C.8080706@siemens.com>
References: <554797D4.5080704@siemens.com> <5547A614.9020109@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5547A614.9020109@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2015-05-04 19:02, Peter Hurley wrote:
> Hi Jan,
> 
> On 05/04/2015 12:01 PM, Jan Kiszka wrote:
>> When nr_uarts was set to 0 (via config or 8250_core.nr_uarts), we crash
>> early on x86 because serial8250_isa_init_ports dereferences base_ops
>> which remains NULL. In fact, there is nothing to do for that function if
>> there are no uarts.
> 
> Thanks for finding this.
> 
> So nr_uarts == 0 effectively disables the 8250 driver. Is there any 
> reason not to simply abort the driver init instead?

I'm not very deep into this code, just stumbled over this while trying
some, well, unusual configurations.

If you prefer to handle this differently, I can recode it, of course.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
