Return-Path: <SRS0=+90y=4V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8459C3F2D1
	for <linux-serial@archiver.kernel.org>; Wed,  4 Mar 2020 20:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7579221775
	for <linux-serial@archiver.kernel.org>; Wed,  4 Mar 2020 20:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iebuqWBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCDUJU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:09:20 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52139 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgCDUJT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Mar 2020 15:09:19 -0500
Received: by mail-pj1-f66.google.com with SMTP id l8so1382775pjy.1
        for <linux-serial@vger.kernel.org>; Wed, 04 Mar 2020 12:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fVWrQMKbqoplD/Oaam0FvwkWhjl3efFR5VHZCGG6srw=;
        b=iebuqWBLS90Q0BVU+DK0De6ptXlRQjnPB0svrq3P4UJTfK4QZfGKt/A9ZBZUrGY1lb
         YQuMO0IXaZp+RAfhXCcP/GWxAifDASDigA+F3izTmsah9uD0rgMiweHlxIpST3v2CqUg
         nB78HVlmRV+sPQT3v3fcu/Li3EOUh8jYKO0b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fVWrQMKbqoplD/Oaam0FvwkWhjl3efFR5VHZCGG6srw=;
        b=b9tBXtTSKkzGJs+jK7JE6aVWHSHFw0t1EnyoQ6AxAaMJXtmO3hFxJXys6xpMycMBsj
         O3swzNcDyewrmJn4vz9FD6pM79oqQ0gsikUqdLg1+vUrBCqh0sdpcPH6CFnvokvCa+/X
         BjlOkOU9xDHmjFof8ZNZWR4w9XegANJ9d356aE0+7WYzXKjEvp3Yh0ZorTsIpo9GQtdb
         5HTeL/NZeeQUC8UXaH2rKXIat1lKkMkexzJxK8OtyGyNYBZXW9sz6aEvxl8Isy67I3v1
         h7B6wgtqeiByH6ygJwYqZe0rx7M6C10RYn2IKME2iXNrPCGpzVj9FLxSb4OZ7YzRaeWc
         lGXQ==
X-Gm-Message-State: ANhLgQ2PlE3NawNenbACmlq5q82/jwNngJnI/+3AgV7Rn1/rKadOPrfH
        kPCibaJx2ss94Wwjm0ixDS9hJA==
X-Google-Smtp-Source: ADFU+vtd3GdGpgyioHfDLBVA7YkNLG9EwP9nP8h+HafEWaxUAHmypsiAgcV7a3VG78CgJbbV0nFZIQ==
X-Received: by 2002:a17:90a:b381:: with SMTP id e1mr4675544pjr.38.1583352558596;
        Wed, 04 Mar 2020 12:09:18 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id w7sm12798393pfj.167.2020.03.04.12.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 12:09:17 -0800 (PST)
Date:   Wed, 4 Mar 2020 12:09:16 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Roja Rani Yarubandi <rojay@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, akashast@codeaurora.org,
        msavaliy@qti.qualcomm.com
Subject: Re: [PATCH V4] tty: serial: qcom_geni_serial: Fix GPIO swapping with
 workaround
Message-ID: <20200304200916.GS24720@google.com>
References: <20200304112203.408-1-rojay@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200304112203.408-1-rojay@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 04, 2020 at 04:52:03PM +0530, Roja Rani Yarubandi wrote:
> Add capability to support RX-TX, CTS-RTS pins swap in HW.
> 
> Configure UART_IO_MACRO_CTRL register accordingly if RX-TX pair
> or CTS-RTS pair or both pairs swapped.
> 
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>

Please make sure to collect tags from previous versions (unless there are
major changes), like Stephens 'Reviewed-by' or my 'Tested-by'.

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
