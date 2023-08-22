Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B026EE49A5
	for <linux-serial@archiver.kernel.org>; Wed, 23 Aug 2023 02:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjHWCQx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Aug 2023 22:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjHWCQv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Aug 2023 22:16:51 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 19:16:43 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB71E4A
        for <linux-serial@vger.kernel.org>; Tue, 22 Aug 2023 19:16:43 -0700 (PDT)
X-AuditID: cb7c291e-055ff70000002aeb-06-64e5539c7d98
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 03.12.10987.C9355E46; Wed, 23 Aug 2023 05:32:28 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=I919c5iou+2apJpSue2Vy7KzlAWMIrOa8DqKlT+Y6Kasgncc6KmsDT6EoEukqQmxE
          wT7xQqGfzULr30LhLhOwc57hryGQ6a2hDDSlgbZvHtrxMq3pPQJykznwQ/2PUC6Dj
          tmWGelgG7NlpRqWyInmZh5SSfP51Y1iIbKzdl56M0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=bVUJPjkPIfQMoUnhMpvf5lWPU1oKpGZSjREMvZlQpBKuB7fux4I8KTaFWAXNte3LH
          Tbd8mj2gcPjF7BYWsxU0nJB1LLZg2NTuIrfthNG0EnWPVj9c5TkxGV4uod77zA9/2
          uXzeT07Pp6mqWQnu6OUYhWD3pgZXpJB6w4KDjAMUo=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:07 +0500
Message-ID: <03.12.10987.C9355E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-serial@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:21 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVyyUKGW3dO8NMUgw2HDS3OLO5ld2D0+LxJ
        LoAxissmJTUnsyy1SN8ugStjyboLLAW7mSva+hexNDA+Zupi5OSQEDCRmDl/HmsXIxeHkMAe
        JonlV1YzgzgsAquZJbbumMQK4Txklmi4fpgFpEVIoJlR4tARzS5GDg5eAWuJ/hOpIGFmAT2J
        G1OnsIHYvAKCEidnPmGBiGtLLFv4mhmknFlATeJrVwlIWFhATOLTtGXsILaIgILEm5aXzCA2
        m4C+xIqvzYwgNouAqsSMpZPYIbZKSWy8sp5tAiP/LCTbZiHZNgvJtlkI2xYwsqxilCiuzE0E
        BlqyiV5yfm5xYkmxXl5qiV5B9iZGYBCertGU28G49FLiIUYBDkYlHt6f656kCLEmlgF1HWKU
        4GBWEuGV/v4wRYg3JbGyKrUoP76oNCe1+BCjNAeLkjivrdCzZCGB9MSS1OzU1ILUIpgsEwen
        VAMjb9FDzUx+pw8reJVCAudYPdJZEXyP0XLr3T+Br2Y/ZDupJ3c61maxzOrklxbFfi//Zz//
        o9Z3LOlbzZe4p/71gncXHedsrFz3vrlcX2Dy052Tp0o2yEo/EMnWTdI4/PDh9srTDILhkV/i
        JblUuZ+5X4u+EbznWseNQ4+UTHpYHPUs9ySrxDEpsRRnJBpqMRcVJwIAe81Blj4CAAA=
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

