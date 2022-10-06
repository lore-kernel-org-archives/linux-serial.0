Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45888C433F5
	for <linux-serial@archiver.kernel.org>; Thu,  6 Oct 2022 07:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJFHIO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 Oct 2022 03:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiJFHIM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 Oct 2022 03:08:12 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3130B2B260
        for <linux-serial@vger.kernel.org>; Thu,  6 Oct 2022 00:08:11 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29677mOV033239;
        Thu, 6 Oct 2022 02:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665040068;
        bh=ZnXFPZ3h010mA2HlyJ1xU4tjPdu8KbHUUxkySI6c9M0=;
        h=Date:From:Subject:To:References:In-Reply-To;
        b=e35kpUsldV+UX6tadu06em6ZKKeFEvzXoScwey20wDTuAQwwVVX9Uh8oEzkDn0VCf
         j0E3CgafGzR83Q05Cf+LA9abdUF5y5FUiDC1wNwntZauSHu6kEW3cnn0hviO6CdQRD
         6YRlp4orl3J6LgcvN55F9F2/29SBUCYaZOmeYrlE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29677mt9031442
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Oct 2022 02:07:48 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 6 Oct
 2022 02:07:48 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 6 Oct 2022 02:07:48 -0500
Received: from [10.250.233.127] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29677hgI064107;
        Thu, 6 Oct 2022 02:07:44 -0500
Message-ID: <cda09b02-a1ca-67a0-a6f6-4e0793605ce1@ti.com>
Date:   Thu, 6 Oct 2022 12:37:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] serial: 8250: 8250_omap: Support native RS485
To:     Bin Liu <b-liu@ti.com>, Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-serial@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
References: <b9f5e4b01f10bb692fc78df668f686dd33d8c036.1664279959.git.lukas@wunner.de>
 <20221003151059.mypganj25awuxc2d@iaqt7> <20221003194224.GC12171@wunner.de>
 <20221004134541.pnp6ts26p22rcwra@iaqt7>
Content-Language: en-US
In-Reply-To: <20221004134541.pnp6ts26p22rcwra@iaqt7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 04/10/22 7:15 pm, Bin Liu wrote:
> Hi,
> 
> On Mon, Oct 03, 2022 at 09:42:24PM +0200, Lukas Wunner wrote:
>> On Mon, Oct 03, 2022 at 10:10:59AM -0500, Bin Liu wrote:
>>> On Tue, Sep 27, 2022 at 02:10:01PM +0200, Lukas Wunner wrote:
>>>> Recent TI Sitara SoCs such as AM64/AM65 have gained the ability to
>>>> automatically assert RTS when data is transmitted, obviating the need
>>>> to emulate this functionality in software.
>>>>
>>>> The feature is controlled through new DIR_EN and DIR_POL bits in the
>>>> Mode Definition Register 3.  For details see page 8783 and 8890 of the
>>>> AM65 TRM:  https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
>> [...]
>>>> -	if (up->port.rs485.flags & SER_RS485_ENABLED)
>>>> +	if (priv->habit & UART_HAS_NATIVE_RS485)
>>>> +		serial_out(up, UART_OMAP_MDR3, priv->mdr3);
>>>
>>> This makes the NATIVE_RS485 always used if the SoC supports it, but
>>>
>>>> +	else if (up->port.rs485.flags & SER_RS485_ENABLED)
>>>>  		serial8250_em485_stop_tx(up);
>>>
>>> there are cases em485 should be used even if SoC supports NATIVE_RS485.
>>> For example:
>>> - the design has pinmux conflict and the RTS pin has to be used for
>>>   something else. Then a GPIO pin would be used for RS485 DE control;
>>> - the design requires customized delay_rts_before_send or
>>>   delay_rts_after_send which NATIVE_RS485 doesn't support;
>>>
>>> So we might need an option for such usecases. A device tree flag?
>>
>> I expect those cases to be rare, hence do not see the need to
> 
> Maybe rare, but I know some projects use GPIO for DE control.
> 
>> address them right from the start.  Support for falling back
> 
> So I think missing it is a regression, because this patch forces to
> use the RTS pin for DE control, this breaks the existing projects which
> use GPIO for RTS/DE or have customized delay_rts_{before,after}_send.

I agree with Bin. This patch as such can break DTs which intend to use
GPIO based DE.
Quick fix would be to simply look for presence of rts-gpios property in
DT, if so fallback to registering serial8250_em485_*. This should avoid
regressing DTs using GPIO for DE control.

Regards
Vignesh

