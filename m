From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: 8250: Prevent kernel crash with nr_uarts=0
Date: Mon, 04 May 2015 14:52:49 -0400
Message-ID: <5547C001.8040400@hurleysoftware.com>
References: <554797D4.5080704@siemens.com> <5547A614.9020109@hurleysoftware.com> <5547B04C.8080706@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5547B04C.8080706@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 05/04/2015 01:45 PM, Jan Kiszka wrote:
> On 2015-05-04 19:02, Peter Hurley wrote:
>> Hi Jan,
>>
>> On 05/04/2015 12:01 PM, Jan Kiszka wrote:
>>> When nr_uarts was set to 0 (via config or 8250_core.nr_uarts), we crash
>>> early on x86 because serial8250_isa_init_ports dereferences base_ops
>>> which remains NULL. In fact, there is nothing to do for that function if
>>> there are no uarts.
>>
>> Thanks for finding this.
>>
>> So nr_uarts == 0 effectively disables the 8250 driver. Is there any 
>> reason not to simply abort the driver init instead?
> 
> I'm not very deep into this code, just stumbled over this while trying
> some, well, unusual configurations.

Ok; I wasn't sure if this was related to some weird setup that needed
the 8250 driver loaded but in-op.

> If you prefer to handle this differently, I can recode it, of course.

Yes, please. We should bail out of any initialization if nr_uarts == 0.

That would be:
1. univ8250_console_init()
	The return value is ignored but the console should not be registered.

2. early_serial_setup()

	if (nr_uarts == 0)
		return -ENODEV;

3. serial8250_init()

	if (nr_uarts == 0)
		return -ENODEV;


Regards,
Peter Hurley
