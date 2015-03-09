From: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 1/1] serial: 8250_dw: Fix get_mctrl behaviour
Date: Mon, 9 Mar 2015 11:51:34 -0700
Message-ID: <54FDEBB6.1060400@broadcom.com>
References: <jonathar@broadcom.com> <1424997357-31487-1-git-send-email-jonathar@broadcom.com> <1424997357-31487-2-git-send-email-jonathar@broadcom.com> <CAE_wzQ-43+oGAmyJ_cgso1XfnCYFGVczPvePG++x=povcAPOdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAE_wzQ-43+oGAmyJ_cgso1XfnCYFGVczPvePG++x=povcAPOdA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dtor-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Desmond Liu <desmondl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On 15-03-09 11:40 AM, Dmitry Torokhov wrote:
> On Thu, Feb 26, 2015 at 4:35 PM, Jonathan Richardson
> <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
>> @@ -334,6 +342,30 @@ static int dw8250_probe_of(struct uart_port *p,
>>         if (id >= 0)
>>                 p->line = id;
>>
>> +       if (of_property_read_bool(np, "dcd-override")) {
>> +               /* Always report DCD as active */
>> +               data->msr_mask_on |= UART_MSR_DCD;
>> +               data->msr_mask_off |= UART_MSR_DDCD;
>> +       }
>> +
>> +       if (of_property_read_bool(np, "dsr-override")) {
>> +               /* Always report DSR as active */
>> +               data->msr_mask_on |= UART_MSR_DSR;
>> +               data->msr_mask_off |= UART_MSR_DDSR;
>> +       }
>> +
>> +       if (of_property_read_bool(np, "cts-override")) {
>> +               /* Always report DSR as active */
>> +               data->msr_mask_on |= UART_MSR_DSR;
>> +               data->msr_mask_off |= UART_MSR_DDSR;
>> +       }
>> +
>> +       if (of_property_read_bool(np, "ri-override")) {
>> +               /* Always report Ring indicator as inactive */
>> +               data->msr_mask_off |= UART_MSR_RI;
>> +               data->msr_mask_off |= UART_MSR_TERI;
> 
> This looks like a typo. Should the 1st line be data->msr_mask_on by any chance?

I think the code is correct. The signals other than ri need to be
reported as active (masked on) if specified, but ri needs to be inactive
(masked off) unlike the other 3. This is stated in the kernel docs
mentioned in the commit. ri behaves differently than the others.

> 
> Thanks,
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
