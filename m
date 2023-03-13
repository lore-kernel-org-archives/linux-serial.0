Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96021C61DA4
	for <linux-serial@archiver.kernel.org>; Mon, 13 Mar 2023 18:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCMSdw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Mar 2023 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjCMSdV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Mar 2023 14:33:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC5F85B10
        for <linux-serial@vger.kernel.org>; Mon, 13 Mar 2023 11:31:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id ja10so4322172plb.5
        for <linux-serial@vger.kernel.org>; Mon, 13 Mar 2023 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eventsattendeesus-us.20210112.gappssmtp.com; s=20210112; t=1678732289;
        h=disposition-notification-to:content-language:thread-index
         :mime-version:message-id:date:subject:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t/44Ab5TKp85B7svqv8lF+Dhh3A7+/fEnmNeJfyGEbE=;
        b=OOAy/A7b6pONVwfKR/Nl5ovx+axCXboTIF0vHMeXUt4WokQmo7Lzuo+TeRmzQ2JIr0
         /Euc3ayAG2ZRjQU+z7RnJdU+HUdUgQZT0R8S2VYnUE5yPIhTPNpZgdG2tG8zaGn9sIwq
         MkAXjQ8cWT067aXkNJed2cyQmHsVL9wQreqO29gZ2C69lIYzIbSs+kAnZUGZCelfez2k
         JMm1gvGOWKWeo4b+jrhEh2miRcd2SmFh0zdNDtv8XftHvvFxIsR5LSKsWPAKwhQWuMy4
         Rq9fiRMkIptpeFHkzoUVShoXvemgTFmDo1QYVZa9AXAzjMVtUaWjXpKnSxZwLIc3qdXf
         7mCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678732289;
        h=disposition-notification-to:content-language:thread-index
         :mime-version:message-id:date:subject:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/44Ab5TKp85B7svqv8lF+Dhh3A7+/fEnmNeJfyGEbE=;
        b=VBujHFIx8nfymvQMZJUx+RHug/8158JkUnon+3ogDDVPa16gVDRVqppEcMtqdXUhZs
         Mx5qcGF/SbdmjXyN4J9Ce/Hp+FFR41+1aQFp/BUHsGaLpeXxwwMNvF7+t5+cx7lAYzfQ
         XqHk5WlBMvxfVJFbopAmPobSPhThezdmgOONmbo39jakkqDDeRpSs8KZn2EVXmqGaTtE
         GqAC5bgna59RTULlcUaLSFhoLeIA+qN12wSXt6WnvrKY4FpH3PW+lla51BMrXyDzLCDH
         DOs2cKjhKE+m8RlPEMujUj67llWigOUhF1hmyu+/pdu2g04jIOAxOQ90u0DIIPt0tCZx
         vLsw==
X-Gm-Message-State: AO0yUKVgFoeXu3GKLi1WNRBRjlWX0O4FQJJVfYb8QywxUm4HdqZwx/Pl
        mBKk1k7VUthB11zd5vLx48qJZ81jDewiCdESmcc=
X-Google-Smtp-Source: AK7set+qmgE1iHErYidlF6QWzc2R6KVa8sF323PtdtYc5DdmK7cHPrUN7bb7nKTm+esIKQexZn0cnQ==
X-Received: by 2002:a17:902:bd41:b0:19c:f096:bbef with SMTP id b1-20020a170902bd4100b0019cf096bbefmr11607735plx.49.1678732288756;
        Mon, 13 Mar 2023 11:31:28 -0700 (PDT)
Received: from DESKTOPHHDSR42 ([27.7.187.4])
        by smtp.gmail.com with ESMTPSA id kn3-20020a170903078300b0019f114570b0sm194168plb.152.2023.03.13.11.31.27
        for <linux-serial@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2023 11:31:28 -0700 (PDT)
From:   "Nikki.Lopez" <nikki.lopez@eventsattendeesus.us>
To:     <linux-serial@vger.kernel.org>
Subject: Vger
Date:   Mon, 13 Mar 2023 13:31:25 -0500
Message-ID: <04de01d955da$05a018f0$10e04ad0$@eventsattendeesus.us>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_04DF_01D955B0.1CCA3800"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdlV2gRrw83oRHCDQAmZOyLCht5yBw==
Content-Language: en-in
X-MS-TNEF-Correlator: 00000000D9765D6F7900ED4892AF9EEB54974A130700C3B68E10F77511CEB4CD00AA00BBB6E600000000000D00008F59F92E3AFF314E81E457137EA242050000000041B10000
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_04DF_01D955B0.1CCA3800
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

Would you be interested in reaching out "Automate Show 2023" attendees
database? 

 

Attendees: Machine Builders, Distributors , R&D Labs, OEMs, Technologies,
Manufacturers, Engineers, Technicians, Decision makers and more...

  

Please let me know your interest on this, so that I would be very happy to
provide you with counts and cost.

 

Awaiting Response,

Nikki Lopez 

Marketing Executive

 

Please response with "End" if not required

 


------=_NextPart_000_04DF_01D955B0.1CCA3800
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

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
wAAAAAAAAEYAAAAABoUAAAAAAAALAH+ACCAGAAAAAADAAAAAAAAARgAAAAAOhQAAAAAAAAMAgoAI
IAYAAAAAAMAAAAAAAABGAAAAABiFAAAAAAAAAwDNgAggBgAAAAAAwAAAAAAAAEYAAAAA64UAAAkE
AAAFAO+AKQMCAAAAAADAAAAAAAAARgEAAAAQAAAARQBNAE0ATQBvAHYAZQAAAAAAAAAAAPA/CwAf
DgEAAAACAfgPAQAAABAAAAAkeITed3f8S6CUMZu1wDVsAgH6DwEAAAAQAAAA2XZdb3kA7UiSr57r
VJdKEwMA/g8FAAAAAwANNP0/rQ4DAA80/T+tDgIBFDQBAAAAEAAAAOkv63WWUESGg7h95SKqSUgC
AeJlAQAAABQAAAADQL5ZnLZtTYnSv26LRYN9AAPZcwIB42UBAAAAFQAAABQDQL5ZnLZtTYnSv26L
RYN9AAPZcwAAAAIBfwABAAAAjQAAADAwMDAwMDAwRDk3NjVENkY3OTAwRUQ0ODkyQUY5RUVCNTQ5
NzRBMTMwNzAwQzNCNjhFMTBGNzc1MTFDRUI0Q0QwMEFBMDBCQkI2RTYwMDAwMDAwMDAwMEQwMDAw
OEY1OUY5MkUzQUZGMzE0RTgxRTQ1NzEzN0VBMjQyMDUwMDAwMDAwMDQxQjEwMDAwAAAAAAMABhA8
s2KqAwAHEGkBAAADABAQAAAAAAMAERAAAAAAHgAIEAEAAABlAAAASEksV09VTERZT1VCRUlOVEVS
RVNURURJTlJFQUNISU5HT1VUIkFVVE9NQVRFU0hPVzIwMjMiQVRURU5ERUVTREFUQUJBU0U/QVRU
RU5ERUVTOk1BQ0hJTkVCVUlMREVSUyxESQAAAABcVQ==

------=_NextPart_000_04DF_01D955B0.1CCA3800--

