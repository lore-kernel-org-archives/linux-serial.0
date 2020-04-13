Return-Path: <SRS0=NZaJ=55=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38524C2BA19
	for <linux-serial@archiver.kernel.org>; Mon, 13 Apr 2020 10:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D7C20732
	for <linux-serial@archiver.kernel.org>; Mon, 13 Apr 2020 10:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQYKaPXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgDMKJr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728131AbgDMKJl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Apr 2020 06:09:41 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5299C00861B;
        Mon, 13 Apr 2020 03:00:48 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t11so8045311ils.1;
        Mon, 13 Apr 2020 03:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Fh+7I1nkl6E4OzdC/8Kb7+iYk/dpPtFFiLYTuSRlqc=;
        b=MQYKaPXnXdR08uDLBNJFXCoLmScqfdF0zA5PJ9vcgwyZlaMidV2d5DvAgSLiECYamH
         nqkzukGFfZb6nwSiKPltyngON8ChcHHxbDj1Xmc7z7ds2wQZmpjZaP300cu3Nt+NpLdo
         8vNcURIBBdgW7+9gSpidTL1u5rGK/6vKS3PWj0yay+qJBt56MKoKhCWIOIUBleY1uBrP
         WnIR/CHcM5Y4IJjWKhspbmT5FCj4eTwPYff8t9WecyA9q2i+sN+sniv1iu/Yyy0bYVGn
         8T9AVS8OMSB3TLs6HTREIICo6XQf9AcB88xOE4sD6Oki4vx42Cov8M/Jr0W69DOJtscE
         0rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Fh+7I1nkl6E4OzdC/8Kb7+iYk/dpPtFFiLYTuSRlqc=;
        b=GfzacWdfGmxsXEj8WepKP9jQlWPAz/kFwdm56RmfHhzaH66C/jtUWd2ELKP3MX3I+U
         JQE8j+NRSGz32faeyw3WsSiPSU2+BENSE+7orKQMnc0BPQwV2geruhIQIsDnmJY18WuA
         ZY9mqIc9Gl3+fwz6//uyId/mgGDG9CQI+1aScwd77+sQzkqUahwK3bjGBY8eSZhAJseY
         Rb4IAy+kQ/CsbwF+NklhvQn+ZFfghwiKJhgYx2k7e+YkFqiiHiYzKPLRkXnqlPy8cV7R
         A5Ox06S9pnJWBRvgK2QK8RyLJt2f9Qlk3d59dBwqgwwoyhGnPCWl4/T9i/2F73hLz/Jf
         IwOw==
X-Gm-Message-State: AGi0PuaJD8mxuYARnwyL46MYtFZ/JET7t80ML4LMB2iKJxzh+eZB41Ja
        G8fKY+RY2LLVTG3HuYrgPsrEcBjkPcuov88V1EkHs5i0
X-Google-Smtp-Source: APiQypIA0oldmzxseP+rUre/aNgrThAcSTbX3lATEBnJG6MdpbCZKGbma9DopJXmarexktqodGEFAslUUE+SAesQ2MI=
X-Received: by 2002:a92:a312:: with SMTP id a18mr16124853ili.249.1586772048130;
 Mon, 13 Apr 2020 03:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <1586413563-29125-1-git-send-email-raviteja.narayanam@xilinx.com>
In-Reply-To: <1586413563-29125-1-git-send-email-raviteja.narayanam@xilinx.com>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Mon, 13 Apr 2020 15:30:36 +0530
Message-ID: <CAKfKVtFHhz-wD-2fiJVRMXxupe=YRZQ4SV-VU+u=Yxe3gfmvrg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] serial: uartps: Add tx_empty checks
To:     Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jslaby@suse.com, Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Raviteja,
thanks for the patch.

On Thu, Apr 9, 2020 at 11:59 AM Raviteja Narayanam
<raviteja.narayanam@xilinx.com> wrote:
>
> This patch series does the following:
> Use cdns_uart_tx_empty function in the driver.
> Wait for empty.
>
> v2:
> Modified the wait in console setup and used cdns_uart_tx_empty function
> in console_write as suggested by Maarten.
>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

> Raviteja Narayanam (2):
>   serial: uartps: Wait for tx_empty in console setup
>   serial: uartps: Use cdns_uart_tx_empty in console_write
>
>  drivers/tty/serial/xilinx_uartps.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> --
> 2.7.4
>
