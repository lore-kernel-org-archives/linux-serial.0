Return-Path: <SRS0=hLv5=BX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9FCC433E1
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 16:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D5D20855
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 16:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="r9t3RmzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgHMQnA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:43:00 -0400
Received: from mail-mw2nam10on2104.outbound.protection.outlook.com ([40.107.94.104]:53665
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726131AbgHMQm7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Aug 2020 12:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCRMkV/Qt3kvhlwcC+ABTIZ/5mZtXtXklRXs7dNfrixHKMnvBP88ykqhvqlZp1dFQfJOoZG0Hi4JjQg6f6+KE43z6M5ehQrl06VabgMJ2h1tKkRbgefgp1cXWVQwLlGEkWb7lWcke+SbF3gERCpWbYrWKq9g7JWzpH3lcFcl63u3OZ3bUE/illnFKV8Rerh9RRYiwCDvifYP/dkPywJx6ovAFdWgRwwQjjE7ShLBpclaRQGX0+lUu7EAMmbOBjEhV4swl3iM2DZI+rq02MbJiN3nYF1YEsieTDBS3oHeZosY7dYC6UUJVC6/wwzqmJizrAYToREGnlS96OpuS8SPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izE0hRiteq83wOgh1uH+sUebIKchseRmyiO/ljf3tYg=;
 b=jGDPUH0lGtlOpiXxVpK/CwPiG0KYG5GLbb1O8d9qAjrrPhx+eh96V5vSm4FmmsmbJIZCWOCPv5Wz+UYl6F9cy8HF/YH5yTyf5M2/xH1hCVmi5AlrjhkOXF1ZNRxGJ7LYI6DntmfDPlyB5DG7fTNn4A0PLDw0P8nVTPO0oXtzaX74+b/iR1tcJCZg8ezKCfHuJ7oYPo6ZZNHe3WJIPjNsjOOstAzlN0BWKMApG1IoSnBs+7qqPocv1FfQ+kb90fQ5IUHSqyY7PASlg93DGdpFV8tb564gPEV1p/PeGK/33HI7jQttyiH6nKSnZrka+WLAZ6/wGnNU1TgTLRB73lFg3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izE0hRiteq83wOgh1uH+sUebIKchseRmyiO/ljf3tYg=;
 b=r9t3RmzWVrS26SAyJr8ADOiHcLU3eWQmbU4hWPMTptqh1h+DeNw1y30MIikTx34xgcRY7cuJ/sb5y+kiY2bS1ebG+Jw+7l04QQ4DuInj8UjgQlkwfyKkKsd+Av6HpKEdrfxuwW6Xfof9XoZc/FK7Zro66PlsBxHIhdbQr96FPZc=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from BN8PR11MB3604.namprd11.prod.outlook.com (2603:10b6:408:83::19)
 by BN6PR11MB0051.namprd11.prod.outlook.com (2603:10b6:405:65::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Thu, 13 Aug
 2020 16:42:57 +0000
Received: from BN8PR11MB3604.namprd11.prod.outlook.com
 ([fe80::9caa:fe2f:bbe7:123f]) by BN8PR11MB3604.namprd11.prod.outlook.com
 ([fe80::9caa:fe2f:bbe7:123f%5]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 16:42:57 +0000
Date:   Thu, 13 Aug 2020 12:42:54 -0400
From:   Valmer Huhn <valmer.huhn@concurrent-rt.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, sudip.mukherjee@codethink.co.uk,
        jan.kiszka@siemens.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_exar: Bug fix for determination of number
 of ports for Commtech PCIe cards
Message-ID: <20200813164254.GB345440@icarus.concurrent-rt.com>
References: <20200812214937.GA332930@icarus.concurrent-rt.com>
 <20200813135111.GW1891694@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813135111.GW1891694@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: BN1PR12CA0021.namprd12.prod.outlook.com
 (2603:10b6:408:e1::26) To BN8PR11MB3604.namprd11.prod.outlook.com
 (2603:10b6:408:83::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from icarus.concurrent-rt.com (12.220.59.2) by BN1PR12CA0021.namprd12.prod.outlook.com (2603:10b6:408:e1::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Thu, 13 Aug 2020 16:42:56 +0000
X-Originating-IP: [12.220.59.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2aa83db-7f70-4fca-7c7a-08d83fa7eec0
X-MS-TrafficTypeDiagnostic: BN6PR11MB0051:
X-Microsoft-Antispam-PRVS: <BN6PR11MB00511D5D06A19DAF567CD440A1430@BN6PR11MB0051.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHxkVtiXbi5RuQVP9zLPFq7gkuT4V8T127y+jeD6pAb4hc/fkEnT5v9Ur8xinWV8XUl/6bfHYir2ljVdQr201Hn0VDUcJqRXjK1gBryPjTTbVua8+x7aYRIize3M6l80+EHXh40mfEdDiRQvhiA2bz59claQaMKv1eQVpjGhULDNTaWKkXjLivmeOvlaalZZl2L2I89Kgqnj8WWjfeIEi3aVg1mIqGBa+prlhYCdkU0KV64QODm9onEv2AwKlp6Mkj04G+Nd6WYZ1IGj+pLJZcb4+aHYNxpLK8qliWCoARP8QOx/bQIv04TnJU7TB8UX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3604.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(376002)(136003)(396003)(39840400004)(4744005)(44832011)(186003)(16526019)(7696005)(4326008)(33656002)(66946007)(66476007)(26005)(2906002)(52116002)(6916009)(1076003)(66556008)(5660300002)(55016002)(8676002)(508600001)(956004)(8936002)(86362001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: rd469W5u4jvFCwjNVsehUVObPKomgawToFtQ11IRA3k3P9NRRFar3WkkH8l46kAmvaPqkaEGrqW6jxKbsn+XLrGxQXzosYuFcNjepO5j5w6zDyqTjnHgkr5Erh1zYytyjn4JUyT3DFzsX14zO3+yvUwuNLiNWCubVAMG5ZMJTDzrJ2ZiPmB8svsZzVNt9GMDEcobMJLDqIr+20O1/Onr8hOiD5hx0SP/nN33gFV8XgYxxpukLM4OViwZEH7puqcDxK8tX1U4XoWlclSqn1sWWFjmgOGi/QQxrqFEtDmcP633BL5ATOPAd2NhE4972rUrm01hBRLIFTviZLNxPhwqwfj6m8KsYyIvj7Wh4FnnbHcABnFykuayTOqoSYZ8aYSFrPdK+72ecBTKu9EffM35XbZ8PHvLdCR3wXO07d3ZzdGe2nnYjp6rMVjWAFQtgSVqA7ECWX0Mf09VKhiKrUXPylrdywRsqbt/hss/vKqYLdJmTfOGMRcvBuR2wGWneWKm3R781Eo7wamfT3UKwsN7OyR7zUcB/d6AoJRj0CZvhKHXMgJcjl8LApCizaJvPDyP7NZMZrIAVRFZcCyblDKPoMoLx67xaoh3DWzyLy0EWGvgltuhbAf1zHazzkZHy9Hqh2oSrl7Jq6lN7Jv2TB72xQ==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2aa83db-7f70-4fca-7c7a-08d83fa7eec0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3604.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 16:42:57.2424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxwsM9vkCod0TdwjgGdACFZ+VT49OdwNjLr0XeS9/6tEEg101imXhq9Tv0VuvoJ1/GqdHz8khKuquiZfYfct2s/4ojv2lHwAHCyVepfoN5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0051
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 13, 2020 at 04:51:11PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 12, 2020 at 05:49:37PM -0400, Valmer Huhn wrote:
> 
> Thanks for the report. It needs a slight corrections I tell about below.

Thank you very much for your feedback.

> > serial: 8250_exar: Bug fix for determination of number of ports for
> > Commtech PCIe cards
> 
> This should not be present in the body.
> And in the subject it would be better to reduce the text to something like
> 
> serial: 8250_exar: Fix number of ports for Commtech PCIe cards

I will resubmit the patch with this subject line and include the changes
you suggested.

Thank you,
Valmer Huhn
