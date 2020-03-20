Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B365C4332D
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 05:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6073720772
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 05:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XNB4oAJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgCTFgA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:36:00 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:38122 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbgCTFf7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 01:35:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584682559; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=3o1RZ/6bELZAsXOfwev81T339te60gO/KqDzjUk4CZA=; b=XNB4oAJKVpJ8cfXinTQS2IRJMQ73mK259Znv/8G3c5eihSjOrAAJk3ZdMMMcyDGzsWBmi94n
 IxqotdLZ7xNDKNy3JmZmNPb6Eqb3VQDZX84Ihi4Xk4dByS+ixeEd9GRuaX3uecG1QObXi5p8
 RWlmrGWp02HePLCehqoR3mgGo0I=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e745637.7f9b3d093bc8-smtp-out-n03;
 Fri, 20 Mar 2020 05:35:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D3BAAC44788; Fri, 20 Mar 2020 05:35:51 +0000 (UTC)
Received: from [192.168.0.13] (unknown [183.83.138.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A570FC433CB;
        Fri, 20 Mar 2020 05:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A570FC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH V2 7/8] spi: spi-qcom-qspi: Add interconnect support
To:     Evan Green <evgreen@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wsa@the-dreams.de, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-8-git-send-email-akashast@codeaurora.org>
 <20200314005817.GN144492@google.com>
 <3aeb3083-2a31-b269-510d-eb608ff14ce5@codeaurora.org>
 <CAE=gft58QsgTCUHMHKJhcM9ZxAeMiY16CrbNv2HaTCRqwtmt7A@mail.gmail.com>
 <e2ee1a60-a379-5c78-355a-64aad451a944@codeaurora.org>
 <CAE=gft4xL9+GN2NrM9ewyPg0Fog3pnf_sLGjWRNOg7KynNh-Dg@mail.gmail.com>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <f8f7041b-c21e-2c2c-a6e7-b92e7cc3e90b@codeaurora.org>
Date:   Fri, 20 Mar 2020 11:05:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAE=gft4xL9+GN2NrM9ewyPg0Fog3pnf_sLGjWRNOg7KynNh-Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Evan,
>> IIUC, you meant to say struct icc_req(inside icc_path) will be saving
>> avg_bw and peak_bw so no need to save it outside icc_path?
> Correct, it seems silly to store the same set of values twice in the
> framework, but with different semantics about who's watching it.
> -Evan

Thanks for clarification! Yeah make sense not to introduce the structure 
in ICC framework

Regards,

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
