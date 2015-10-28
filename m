From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] of/fdt: fix error checking for earlycon address
Date: Wed, 28 Oct 2015 10:56:22 -0400
Message-ID: <5630E216.908@hurleysoftware.com>
References: <1445600840-26749-1-git-send-email-yamada.masahiro@socionext.com>
 <562A32EA.20808@hurleysoftware.com>
 <CAL_JsqK6UJxvGt3_y5T+VMxpr7G=PCmQ_Nx0QW-EfeTHOCDMKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqK6UJxvGt3_y5T+VMxpr7G=PCmQ_Nx0QW-EfeTHOCDMKQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ley Foon Tan <lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On 10/27/2015 04:46 PM, Rob Herring wrote:
> On Fri, Oct 23, 2015 at 8:15 AM, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org> wrote:
>> Hi Masahiro,
>>
>> On 10/23/2015 07:47 AM, Masahiro Yamada wrote:
>>> fdt_translate_address() returns OF_BAD_ADDR on error.  It is defined as
>>> a u64 value, so the variable "addr" should be defined as u64 as well.
>>
>> Good catch.
>>
>> I would prefer if fdt_translate_address() returned resource_size_t (which
>> is the proper type for handling addresses as integers) and that type
>> was propagated through early_init_dt_scan_chosen_serial => of_setup_earlycon.
> 
> That can be problematic in the DT code. The size of resource_size_t
> can vary on 32-bit as it is based on phys_addr_t which in turn is
> based on CONFIG_LPAE setting. However, the address sizes in DT are
> fixed and may be 64-bit. So we stick with u64 in the DT code.

I think I see your point about fdt_translate_address(); you want it to
mirror of_translate_address(), yes?  If so, then I have no objection
to this patch and will mark it reviewed.

But the u64 value from fdt_translate_address() should be preserved
at least to the ioremap()/set_fixmap() in earlycon_map() .
I could roll that change into my earlycon series that moves
fdt_translate_address() into of_setup_earlycon(), thus preserving
the u64 value until it's assigned to a phys_addr_t.

Regards,
Peter Hurley
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
