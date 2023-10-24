Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DDDC00A8F
	for <linux-serial@archiver.kernel.org>; Tue, 24 Oct 2023 05:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjJXFqV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Oct 2023 01:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjJXFqU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Oct 2023 01:46:20 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A91120
        for <linux-serial@vger.kernel.org>; Mon, 23 Oct 2023 22:46:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 88D985C0354;
        Tue, 24 Oct 2023 01:46:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 24 Oct 2023 01:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698126374; x=1698212774; bh=c2
        fUwDOAq1jMUuWnxen10wYPl5qB7m1C4ViKWmR8wbE=; b=auTN7fS6Jozjw7yzQ/
        KS52NxCame/JztnLhs6jBHVHkesBERkjKDbuY9UXSOpJ2pfxRl5CJv5DNVcBw5WU
        rWmPWBjagsiLHDsJUPpwjmcYdXGxQTLQuWTZOie+oLVkpeOBRJFO8r2G7JomEkGH
        46UF3M0SsCYAI1Q71+yY0y2KnxxMTh3k6dZrCFkCShTbSuIZ9HOpe26nM8Mmimzh
        kwrmuDk/oLb9CCWh5z6QCSc6oUhC78jVSLkpxVAsYcrwF+eYYnll93Tcjh+hCMpt
        51vARk0gJBe2MKb+yAVotPukXnQNzCuFKzxUdwRHYCvKJcPaksw7QFhjyNpqPjC7
        Ubfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698126374; x=1698212774; bh=c2fUwDOAq1jMU
        uWnxen10wYPl5qB7m1C4ViKWmR8wbE=; b=DMrUx+fxsBLuYB7HUeoOXMoB4hOA5
        omB5P8R5FKP3BPQegRwV+nNlAQbAbULmqj8DrpssGi/ZrptzR5iWGBgsA5TSZb1t
        Cxj0SsPSR9a/rkxh1gPStoNVZKhPD5DU/AxbGAdg3pdWOXEwTJzfZdSYHQK4BkwU
        Rl/ZpDNuOanHvUJimVqGBtezFnxTV4TNwM6+yw5QMEtFhzyF92FRMSP9DfCIuNPo
        xWs+otQ+XtD1UDPwTXqZi/nNtV+q8OAZjgMyVPnvaBF6oDeGF9AfzpuCkmMCWZUi
        VGmynCPV/uGTouejoTCI+PskBk3TSpVRtAIlThSmlqVteJzth/Voe/Urg==
X-ME-Sender: <xms:Jlo3Zb1y8V4fSWNYBk33Tj4cywb2I-DmQGgSvHthJY45c2sDNRCVOA>
    <xme:Jlo3ZaHEFU777AaItWoRkLNovzTFBXXHbs-qG23fnQF1Kxoi9vMavFqPz9UVfMxug
    7eNQbOkekqalopCpL4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeejgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Jlo3Zb62uadAA2ADIW_14M-7Xh0n54ZLGgoBl1Eh4QeJpM2vJGJ74w>
    <xmx:Jlo3ZQ3vTMRm_DGiYd52KZoDvm1XqQr_LGpheCwn9Sef-j_xOAv_8w>
    <xmx:Jlo3ZeE6x5VQV3a6mkDox7Yt_ofJak3NWq59xe3_TDghc5PYlvVdpw>
    <xmx:Jlo3ZQPvm9H_mU51iAlJRSYFEgabsUeu1GG8Y35GdR6KvgSmp45z-Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3C5D1B60089; Tue, 24 Oct 2023 01:46:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <c0a8b32d-8729-4751-91ab-65c62999e446@app.fastmail.com>
In-Reply-To: <202310240429.UqeQ2Cpr-lkp@intel.com>
References: <202310240429.UqeQ2Cpr-lkp@intel.com>
Date:   Tue, 24 Oct 2023 07:45:53 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "kernel test robot" <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [tty:tty-next 17/49] arch/mips/sibyte/swarm/setup.c:146:9: error: implicit
 declaration of function 'vgacon_register_screen'
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Oct 23, 2023, at 22:12, kernel test robot wrote:
> If you fix the issue in a separate patch/commit (i.e. not just a new 
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: 
> https://lore.kernel.org/oe-kbuild-all/202310240429.UqeQ2Cpr-lkp@intel.com/

Thanks for the report, I sent the obvious fix now.

    Arnd
