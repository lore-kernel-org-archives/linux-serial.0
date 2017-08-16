From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] earlycon: initialise baud field of earlycon device structure
Date: Wed, 16 Aug 2017 08:46:21 -0500
Message-ID: <CAL_JsqJaK=xgrzecf3PnPuNSzsnzdvuJ9NZ4uzs4u9Oc77sV2A@mail.gmail.com>
References: <20170815172141.29115-1-Eugeniy.Paltsev@synopsys.com>
 <CAL_Jsq+=LQ0kXtBx7xXJEb0FtfqwQRZoUYtG0oDFnUj_VfoG1A@mail.gmail.com> <1502884362.2586.32.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502884362.2586.32.camel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.com" <jslaby@suse.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 16, 2017 at 6:52 AM, Eugeniy Paltsev
<Eugeniy.Paltsev@synopsys.com> wrote:
> Hi Rob,
>
> On Tue, 2017-08-15 at 14:26 -0500, Rob Herring wrote:
>> On Tue, Aug 15, 2017 at 12:21 PM, Eugeniy Paltsev
>> <Eugeniy.Paltsev@synopsys.com> wrote:
>> > [snip]
>> > @@ -282,7 +283,15 @@ int __init of_setup_earlycon(const struct
>> > earlycon_id *match,
>> >                 }
>> >         }
>> >
>> > +       val = of_get_flat_dt_prop(node, "baud", NULL);
>>
>> No, we already have a defined way to set the baud, we don't need a
>> property in addition. Plus you didn't document it.
>
> I guess by defined way to set the baud you mean setting baud after
> device alias
> in stdout-path property (like stdout-path = "serial:115200n8"), right?
>
> The idea was to reuse "baud" property from serial node to set the
> earlycon baud:
>
> chosen {
>     ...
>     stdout-path = &serial;
> };
>
> serial: uart@... {
>     ...
>     baud = <115200>;   /* Get baud from here */

"current-speed" is already defined for this purpose. If you want to
add that, that's fine.

> };
>
>> > +       if (val)
>> > +               early_console_dev.baud = be32_to_cpu(*val);
>> > +
>> >         if (options) {
>> > +               err = kstrtoul(options, 10, &baud);
>> > +               if (!err)
>> > +                       early_console_dev.baud = baud;
>>
>> This seems fine to do here, but then we should also parse the other
>> standard options here too. And we should make sure we're not doing it
>> twice.
> I added only baud parsing here because we parse only baud from standard
> options
> when register_earlycon is used. (see parse_options function which is
> called
> from register_earlycon)
>
> But I can add other standard options parsing here (probably using
> uart_parse_options + uart_set_options).
> What do you think?

That seems fine as long as consoles can still have their own options.

Rob
