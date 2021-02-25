Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5777FC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 25 Feb 2021 08:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0497364EDC
	for <linux-serial@archiver.kernel.org>; Thu, 25 Feb 2021 08:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbhBYIog (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Feb 2021 03:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232177AbhBYIof (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Feb 2021 03:44:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9F0664EDB;
        Thu, 25 Feb 2021 08:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614242635;
        bh=sY37LZRDH2NSxM7aPCZY8CcPd+J+Ezs0qyk2hFBUfTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4nvq3VDtzyykRLWl0/vWxdtnxdHrhCGkKYXd3t7tDgDhHhDp5+ZckRmrOibPNt5d
         JV/Un5ZT+ne46ktj9W71s/r+Ps9pgV747UQWcYk+RNYxuTdbcEvcr2fHsZRWuNk79G
         ghPR3JFN2ePowRHjtXvWWHV3D33KD0x3nW0feNJCz7cnr/rOkPVObXAVoI12/uuNlu
         DxSkUMc/3HRmMlVykQJ/I6smCTFMDTfuyt44gnXwoCDkSty411e9S4Naxxrk6Z9KrJ
         J9YQSoSsJcKnSqq0iZre8ggPz1Xz571SAhJkYACI9obZ5OxozMJWM/ekxVBDEos0Dd
         3a9GNBj6wQnTg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lFCFp-0008Cx-IV; Thu, 25 Feb 2021 09:44:13 +0100
Date:   Thu, 25 Feb 2021 09:44:13 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Joe Abbott <jabbott@rollanet.org>
Cc:     "Michael G. Katzmann" <michaelk@ieee.org>,
        charles-yeh@prolific.com.tw, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YDdjXXokOlCbYU7b@hovoldconsulting.com>
References: <YDNwxtDxd7JntAXt@hovoldconsulting.com>
 <e2dcc839-3b43-2c80-6ad1-2d97e639b46a@IEEE.org>
 <YDOvLseYXaUHs0lS@hovoldconsulting.com>
 <fb1489c2-b972-619b-b7ce-4ae8e1d2cc0f@IEEE.org>
 <YDPO/JprcDTaPmR4@hovoldconsulting.com>
 <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <cd92ea17-4e0a-2b6c-1032-9a81727841c9@IEEE.org>
 <YDPgVZ4GbNq6cGDP@hovoldconsulting.com>
 <CADuz4ON8Jj5unz_eeD--7n5kp2uQmqeyM_2-DTrTFKFwFtoudw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADuz4ON8Jj5unz_eeD--7n5kp2uQmqeyM_2-DTrTFKFwFtoudw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 24, 2021 at 05:08:28PM -0600, Joe Abbott wrote:
> On Mon, Feb 22, 2021 at 10:48 AM Johan Hovold <johan@kernel.org> wrote:

> > Joe, would you mind posting the output of "lsusb -v" for your device as
> > well?
> >
> Bus 007 Device 002: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port
> Device Descriptor:

> Also, here's the 110b windows wireshark capture
> https://drive.google.com/file/d/1HP5RMRtP11zm4uQNzqlcbILGwebDJaOz/view?usp=sharing

Thanks, Joe!

Johan
