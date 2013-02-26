From: Bastian Hecht <hechtb@gmail.com>
Subject: Re: [PATCH v2 1/3] serial: sh-sci: Add OF support
Date: Tue, 26 Feb 2013 09:09:52 -0600
Message-ID: <CABYn4szH8QnPAj6dkv94wEVr6b=ezb2f7fxyiMnhF7AqOBOMpQ@mail.gmail.com>
References: <1361819215-4115-1-git-send-email-hechtb+renesas@gmail.com>
	<20130225203534.GB19670@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:49395 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759567Ab3BZPJy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Feb 2013 10:09:54 -0500
In-Reply-To: <20130225203534.GB19670@linux-sh.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org

Hi Paul,

2013/2/25 Paul Mundt <lethal@linux-sh.org>:
> On Mon, Feb 25, 2013 at 01:06:53PM -0600, Bastian Hecht wrote:
>> We add the capabilty to probe Renesas SCI devices using Device Tree setup.
>>
>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>> ---
>> Based on the topic/all+next branch from the 17th Feb. I couldn't rebase it on the current HEAD as the armadillo-reference code currently isn't in.
>>
>> changelog v2:
>>  - Renamed title to "Add OF support"
>>  - Removed fixed configurations from driver and added the following binding props:
>>       - renesas,scscr
>>       - renesas,scbrr-algo-id
>>       - renesas,autoconf
>>       - renesas,regtype
>>       See patch for descriptions
>>
> This looks much better, only a few minor nits.
>
>> +Optional properties:
>> +- renesas,autoconf : Set if device is capable of auto configuration
>> +- renesas,regtype : Overwrite the register layout. Some legacy hardware versions
>> +  use a non-default register layout. Possible layouts are
>> +  0 = SCIx_SH2_SCIF_FIFODATA_REGTYPE
>> +  1 = SCIx_SH3_SCIF_REGTYPE
>> +  2 = SCIx_SH4_SCIF_REGTYPE
>> +  3 = SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE
>> +  4 = SCIx_SH4_SCIF_FIFODATA_REGTYPE
>> +  5 = SCIx_SH7705_SCIF_REGTYPE
>> +
> Here I would still opt to provide the full regtype set, even for the
> "standard" layouts, as it's quite possible that newer port-types will use
> older layouts.
>
> In this case you could keep 0 as the probe type (which would be the
> default anyways, so effectively a no-op), and then do the upper bounding
> via SCIx_NR_REGTYPES.
>
>> +/* This array belongs to the DT binding definition "renesas,regtype" */
>> +static const char sci_regtype_modes[] = {
>> +     SCIx_SH2_SCIF_FIFODATA_REGTYPE,
>> +     SCIx_SH3_SCIF_REGTYPE,
>> +     SCIx_SH4_SCIF_REGTYPE,
>> +     SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
>> +     SCIx_SH4_SCIF_FIFODATA_REGTYPE,
>> +     SCIx_SH7705_SCIF_REGTYPE
>> +};
>> +
> At which point all of this can go away.
>
>> +static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
>> +                                                             int *dev_id)
>> +{
> ..
>> +     prop = of_get_property(np, "renesas,regtype", NULL);
>> +     if (prop) {
>> +             val = be32_to_cpup(prop);
>> +             if (val <= 0 || val >= ARRAY_SIZE(sci_regtype_modes)) {
>> +                     dev_err(&pdev->dev, "invalid DT prop regtype\n");
>> +                     return NULL;
>> +             }
>> +             p->regtype = sci_regtype_modes[be32_to_cpup(prop)];
>> +     }
>> +
> You can then compare against SCIx_PROBE_REGTYPE and SCIx_NR_REGTYPES, and
> assign p->regtype the be32_to_cpup() value directly. Which will also make
> it trivial to add new regtypes in the future, we would only need to
> update the binding documentation.

Ok, I slightly disliked that portion anyway in the code as we have the
full mapping from the SCBRR algo ID and only the partial mapping from
the register set. Additionally I wonder if I should add something like

enum {
+     SCBRR_ALGO_INVALID,
       SCBRR_ALGO_1,
       SCBRR_ALGO_2,
       SCBRR_ALGO_3,
       SCBRR_ALGO_4,
       SCBRR_ALGO_5,
};
...
-p->scbrr_algo_id = be32_to_cpup(prop) - 1;
+p->scbrr_algo_id = be32_to_cpup(prop);

to have a straight mapping.

Thanks,

 Bastian
