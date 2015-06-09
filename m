From: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V2 2/3] tty: serial: fsl_lpuart: remove RTS/CTS control
 from set/get_mctrl
Date: Tue, 9 Jun 2015 09:42:28 +0530
Message-ID: <557667AC.3030506@toradex.com>
References: <1433136067-20644-1-git-send-email-bhuvanchandra.dv@toradex.com> <1433136067-20644-3-git-send-email-bhuvanchandra.dv@toradex.com> <20150608091244.GS7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150608091244.GS7557-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, moorray3-5tc4TXWwyLM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, bhuvanchandra.dv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 06/08/2015 02:42 PM, Russell King - ARM Linux wrote:
> On Mon, Jun 01, 2015 at 10:51:06AM +0530, Bhuvanchandra DV wrote:
>> +    /*
>> +     * CTS/RTS can _only_ be handled
>> +     * automatically by the hardware.
>> +     */
>
> That's really not acceptable.  You need to do something here so that you
> can _force_ RTS to be deasserted when the kernel buffers fill up - be
> that by stopping reading characters and letting the FIFO fill up or
> something of that ilk.
Agreed, will fix this.
>
> Ignoring the rest of the flow control system in the kernel is not really
> acceptable.
>

Best regards,
Bhuvan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
