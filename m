Return-Path: <SRS0=EMO6=3B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6815BC33CA7
	for <linux-serial@archiver.kernel.org>; Sun, 12 Jan 2020 02:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B042082E
	for <linux-serial@archiver.kernel.org>; Sun, 12 Jan 2020 02:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbgALCGi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Jan 2020 21:06:38 -0500
Received: from mail3-bck.iservicesmail.com ([217.130.24.85]:59705 "EHLO
        mail3-bck.iservicesmail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731886AbgALCGi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Jan 2020 21:06:38 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jan 2020 21:06:37 EST
IronPort-SDR: MVU3bgLOT8juTEmpJ2wRiuN0S+wth2dsuxcRLRo1y491URUSsogJyDLEL1yDZqjMYToF8txHPG
 VlO99LKLd/SA==
IronPort-PHdr: =?us-ascii?q?9a23=3ACbNX5xxBPXFHy83XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2+MQIJqq85mqBkHD//Il1AaPAdyAraga1aGK6ujJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe61+IRS3oAneucQanJZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxPujysJKiI2/3vSis1wla5WvhWhpwZnw47TeoGaLuZ+cb3EcdwEQ2?=
 =?us-ascii?q?pNR9pcVzBdAoymc4QPD/QOPeNGoIn7u1sCtAWxBQ+1CO3ozT9IgGH53K0j3+?=
 =?us-ascii?q?s/FwHNwQgsEtwSvHjIqdn4MroZX+Kow6nS1TjNYfNY2S3j5obLbx4uru2DU7?=
 =?us-ascii?q?1rfMrNy0QgCx/JgkmMpYD7OT6ey+QDs3Kc7+plTe+hkXAoqx1vrTi128wjio?=
 =?us-ascii?q?7JhoQaylvZ8ih52Jg6JcGmR05hb9+kF51Qty6BOot2WcMtWH1ntDwmxb0BvJ?=
 =?us-ascii?q?63ZigKyJc+yhPZdveJcJCI7wr9WOqMIzp0nm9pdbyjixqo70StxffwW8e03V?=
 =?us-ascii?q?tMsyFLiMPDtmoX2BzW8sWHT/x98Vq/1juXzADT7/1EIVgzlarGN54t2r4wmY?=
 =?us-ascii?q?QXsUTEBiL2nV/5jK6SdkU+5Oeo7/jrb7r8qp+CMI97lxvxMqopmsy5H+s0KB?=
 =?us-ascii?q?YBX3OD9eS90r3s41H5Ta1UgvErkKTVqo3WKMoHqqKjHQNY3Zwv5hi/Aju+1d?=
 =?us-ascii?q?QXh3gHLFZLeBKdiIjpPknDIOjmAvejnVusijlqx/fAPr3uGZjNLmPDn6z9cr?=
 =?us-ascii?q?pn90Fczw8zwcpf55JXEr0BOu78WlfttNzECR80Kwi0w+fhCNVg2YISQHmPDb?=
 =?us-ascii?q?GDMKPTq1CI4vkiI/eDZIALojbxMfsl6OD0jX8/h1AdebOl3ZwNaHC3TbxaJB?=
 =?us-ascii?q?CdYHzxkpIaHH0Ltw4WUuPnkhuBXCRVanL0WLgztQs2EIa3MYCWfo2xjabJ4y?=
 =?us-ascii?q?C9EdUCfm1aB0qTFnHnd56OUPcPQC2XK85l1DcDUO7yZZUm0ESWuRP30fJYKe?=
 =?us-ascii?q?zbsnkAuI7uzsdy4eL7lQo4/np/CMHb02LbHDI8pX8BWzJjhfM3mkd60FrWiv?=
 =?us-ascii?q?Agjg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EyAwDEfRpelyMYgtlMGBoBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBAREBAQECAgEBAQGBaAQBAQEBCwEBGwEDBAGBJYFNUiASk1CBTR+?=
 =?us-ascii?q?DQ4tjgQCDHhWGBxQMgVsNAQEBAQE1AgEBhEBOAReBDyQ1CA4CAw0BAQUBAQE?=
 =?us-ascii?q?BAQUEAQECEAEBAQEBBhgGhXOCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUpMAQ4?=
 =?us-ascii?q?BU4MEgksBATOdegGNBA0NAoUdgkkECoEJgRojgTYBjBgagUE/gSMhgisIAYI?=
 =?us-ascii?q?Bgn8BEgFsgkiCWQSNQhIhgQeIKZgXgkEEdolMjAKCNwEPiAGEMQMQgkUPgQm?=
 =?us-ascii?q?IA4ROgX2jN1d0AYEecTMagiYagSBPGA2IG44tQIEWEAJPjFuCMgEB?=
X-IPAS-Result: =?us-ascii?q?A2EyAwDEfRpelyMYgtlMGBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBaAQBAQEBCwEBGwEDBAGBJYFNUiASk1CBTR+DQ4tjgQCDHhWGB?=
 =?us-ascii?q?xQMgVsNAQEBAQE1AgEBhEBOAReBDyQ1CA4CAw0BAQUBAQEBAQUEAQECEAEBA?=
 =?us-ascii?q?QEBBhgGhXOCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUpMAQ4BU4MEgksBATOde?=
 =?us-ascii?q?gGNBA0NAoUdgkkECoEJgRojgTYBjBgagUE/gSMhgisIAYIBgn8BEgFsgkiCW?=
 =?us-ascii?q?QSNQhIhgQeIKZgXgkEEdolMjAKCNwEPiAGEMQMQgkUPgQmIA4ROgX2jN1d0A?=
 =?us-ascii?q?YEecTMagiYagSBPGA2IG44tQIEWEAJPjFuCMgEB?=
X-IronPort-AV: E=Sophos;i="5.69,423,1571695200"; 
   d="scan'208";a="323121602"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 12 Jan 2020 03:01:13 +0100
Received: (qmail 8737 invoked from network); 11 Jan 2020 23:46:33 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-serial@vger.kernel.org>; 11 Jan 2020 23:46:33 -0000
Date:   Sun, 12 Jan 2020 00:46:30 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghsbchk@gmail.com>
To:     linux-serial@vger.kernel.org
Message-ID: <28433024.172140.1578786393499.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

