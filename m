Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023143.outbound.protection.outlook.com [52.101.83.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE036A033;
	Wed, 30 Sep 2026 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780241; cv=fail; b=c+dWayZIUeOEX0MIg054oZcAkmBc5GGEj7qmbolquziROoO4AYjPvES3Ivg1tV2ZYwMjBslD9YHfvlMVzOTb9yTpLccfOLW9oC5wR0UG/xKvHecHS+bExaOe5C590ID3LvX4D4VcWtsra4bk+rPpNuGfMLCG2O+6cIiVtz2305Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780241; c=relaxed/simple;
	bh=RfiKif3gie8nifzR9tS11fZAdYpgUh3gLSSSfJK4w1E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iWfLkTjq/krmyoMTX98XOa4rvwLRtFWNy1Y0NiUjr3PQNAD6KPDT5ZgSjAmz/SAEIlPyk0PTWp9zQarT5BpIb35349nlnasA9jBkFsddDqnGi3GQ5gveGtAixe2mXnY3D3cTz4f14njx1Nw4UhIVk7X3CPiWcIhb9R0SLpPo0TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=Rx8f8gkz; arc=fail smtp.client-ip=52.101.83.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="Rx8f8gkz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqGA1SRuPok8INmlG57qQPazIdKECzrxwc7+vIylH2r/T93H8EpolACIC8w8L8Q57vwdQCF0TiWlOq0N0gpZVZaQRJNBmIswqrE7ofX0ziosC8f9PC01LuWGJ0/GveAaVbQC5D/yZFpFAoyKQY3wku0yUxjgmHaQxwfGX5Xh03XlRLDmmbfBnluRpulpl8075MU05LYyCIblGKDzXvRbrllCkAkbzb/ZEsRUvRogF4yNnfLJBsxW/ksqX8N0Ki+TyDurRw5c+UndAeRTXVirGYT/BsaFD8caiPPtFVgXicD9Wrj7sFIONE369D0U9pAB9y0wAXMs4H3q6ik+iCqdaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZ1qFuSYxvCbzqn2P94rX7E3SNTJcRG1DmCnVAY7SWM=;
 b=klrRebuakArWzwtJB+BFoI8gJ0woRWSdDldwTmNvwbzMcClN13jvdC9Ix02ttNXELXHKS8fXWnVjb9ocFOfUDLz5m4e5z4v81bG0HVoMmOtuKEjz6sK0HCH4vGegRG4805TaGspQLCX2s2u8H+sRBMoQUjBV60elLuFTfAnnNHM71bFxUdaaqIdka/pVnIkZHBPxO3OPABp/26YtbrxMR+jZDFDsrhTeei7CvHPFoIvoz2Uc2IZVONge76ZTgqZCoMOX1NP0XNc7gtVZSGV4aAH1f84xZi7TEln9B6sWZBVfE0l0R0K4T+UQW1Sdv3ZA4XiFSuYgVOqr0Pb63tdnug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=ziehl-abegg.de; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=ziehl-abegg.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ1qFuSYxvCbzqn2P94rX7E3SNTJcRG1DmCnVAY7SWM=;
 b=Rx8f8gkz3KTECSRGoBEscO866duN1Euq6ndvIKljCevqFfObFoVW4hdJuN5Ymm2SURqXndyqnjUkxH1ZfowY6IPUNj/jICSjXvbhMhYbaShko24G5+oqNLfaRP3KvJGHBqn3g6OwbZcRxFRbummukCcArMz54RJQmvotCQg1iDg=
Received: from PR3PR09CA0010.eurprd09.prod.outlook.com (2603:10a6:102:b7::15)
 by DBAPR02MB6104.eurprd02.prod.outlook.com (2603:10a6:10:183::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 14:57:05 +0000
Received: from ZR1PEPF0000E6B3.eurprd05.prod.outlook.com
 (2603:10a6:102:b7:cafe::78) by PR3PR09CA0010.outlook.office365.com
 (2603:10a6:102:b7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 14:57:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 13.74.137.176) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 13.74.137.176 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.74.137.176;
 helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 ZR1PEPF0000E6B3.mail.protection.outlook.com (10.167.241.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:57:05 +0000
Received: from AM0PR07CU002.outbound.protection.outlook.com (40.93.65.70) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 30 Sep 2026 14:57:04 +0000
Received: from PA7P264CA0199.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36d::19)
 by DB5PR02MB11889.eurprd02.prod.outlook.com (2603:10a6:10:655::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 14:57:01 +0000
Received: from MI3PEPF0000848E.eurprd03.prod.outlook.com
 (2603:10a6:102:36d:cafe::ac) by PA7P264CA0199.outlook.office365.com
 (2603:10a6:102:36d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 14:57:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.242.194) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=fail action=quarantine
 header.from=ziehl-abegg.de;
Received-SPF: Fail (protection.outlook.com: domain of ziehl-abegg.de does not
 designate 91.26.242.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.242.194; helo=mail.za.ziehl-abegg.de;
Received: from mail.za.ziehl-abegg.de (91.26.242.194) by
 MI3PEPF0000848E.mail.protection.outlook.com (10.167.240.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:57:00 +0000
Received: from vEX02.za.ziehl-abegg.de (10.1.201.106) by
 DEKUN-EX01.za.ziehl-abegg.de (10.1.200.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 30 Sep 2026 16:56:34 +0200
Received: from localhost (10.1.200.37) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Wed, 30 Sep
 2026 16:56:34 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hugo@hugovil.com>, <tobias.gannert@ziehl-abegg.de>,
	<joachim.knorr@ziehl-abegg.de>, <david.laight.linux@gmail.com>,
	<Maarten.Brock@sttls.nl>, <crescentcy.hsieh@moxa.com>, Paul Mbewe
	<paultyson.mbewe@ziehl-abegg.de>
Subject: [PATCH v2 RESEND 0/2] serial: sc16is7xx: improve TX FIFO refill
Date: Wed, 30 Sep 2026 16:56:26 +0200
Message-ID: <20260930145628.566535-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DEKUN-EX02.za.ziehl-abegg.de (10.1.200.170) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30228.007
X-TM-AS-Result: No-10--25.468000-8.000000
X-TMASE-MatchedRID: CWQJsOwPredWBEdhLwMbrFmcWIT2GKzJJeVHOyz36PTCnG8raj995953
	NOvzenyJChCyLfzUZU11Rj39DGmIDxs3vNxgt2OKna3BSe2k24bAEu0pi7xsSyqKSt7G+YfDXD4
	Vo+DvQOgdZWjAopQrSZvEOW0bxEpHN7b5iLtubbMIjw+vaMoImxD+Fz0WotuszkXxOoyxTZPJZ8
	m9qdKV9cxYH586jJpeKzjPGuLUS9lK9X0C36DkhO5IMXeX4OViIjLninA2ln0IC+C9uSYtVKuCy
	a2Pe1wkheeWLNKPyWxhlCnNRJU2fcIow0J4q7BtXIfz2HpK/wQK5Gej4vD4ObyEkHXsVu8JFRjL
	i/+L8AKHgSKIUSkqFt9RtdIEmsIU/vXcNl2CXMDzpCt7lk4qW0D52DVfPxI8+wWpop+OSdyHbUQ
	HMhvqjFz8XVkX8kqE+7BBmnJyAhrh+0R5IBKRsr/a0nd+hIFClofw80OHMvhP8StIwFbkBA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--25.468000-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30228.007
X-TM-SNTS-SMTP: 2FEE40DF2D2438AA7F1DC52B8F0FB8F23B176BC476E5D93459AB47FA1482630A2000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	MI3PEPF0000848E:EE_|DB5PR02MB11889:EE_|ZR1PEPF0000E6B3:EE_|DBAPR02MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab649e6-3794-40e4-e25c-08df1f0317cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|13003099007|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original:
 12QiwE5u1uNzRTW2+R/IAzxT7HodVrY614OuCCV1ATPCCwYUBBTSZTZSEehl8+76nobevmf7W2xYMcO0gkjBn4JKD+LIhVGbDV9QNu18PP87VmmuIspLKYEtHDUNbPchkWJ+L13lkJfXQfzvmHr44zfhyRQKpoV4wBLbnSitG3e5KV+f4aFdNBvcIsgTJwGk7F5ibJOx/nYsWgBi0OkqXLUtZcFVbiCnihvs7D8U3+VTe02Q5x17qTQqUWloW3kjU9C37dSXDfM8+lNWyC1cwXd0CFyKRzgPy+GRqp7nUdFIeYCJiZ8MCCq+FUWiXiI+EuIBHeExzqTt1x3ji+P4aEDnMGzNgpA6KcTg9Xwgtkxeedj7TXhL3VnrHK5Re1bDi0M+1PngYir19kzvhY31mX1Pa0zVeNFYj6qqJL45i3fF/RdG/B5NUMmdgx7St/IJZNxzkWMRtlZw28vfyjPsx2nchh/TViBI2fL+EU3PnDBjcFDCAmcsHMRAN+PPycakAt1uZBZf7LcVwBQ5WK1+HlT6aQkUAoBL59aWAdyBdfd3ZZUbCG1NhXjKqArv83whhiPzO38/2UgdIAmmXfhvvAc0r2snvpQIyrKL9sPRw88xz2inHB0iDm0n36BTSicWfqP9KaN4HLWZ4V/9wUX4KWfwZX/PVgSBRA1utK+b6MA=
X-Forefront-Antispam-Report-Untrusted:
 CIP:91.26.242.194;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: sUbRWFvzW0o7QQA417sFu4IPQGnLYsohI9kgHolyAnsdP5wdiQk+N+ZZzHHFOnIag+H3zQrGaTNCn0uSLcUrJN4DB8PnalnBvi73F0mEVN151Kg2xx5cGYkRHz7oUFgpxhD1FVzg7G8bpxomFx/UDrlEejWw3OjjSPVEcMpyA9r7qhOR4h5LFXdJ7XXM5uvkPJGIVNIoyT8EeuSKpg7Baz9USqduQox3GMMSEhhxHGIuLRhZYtwWeydJUKEhf9oufFVvu0o+3dyLSzZzs5XWK6i936KuJEGUsvKBRsWdKmrG1703/AbtS6O0uWPrTwHWR3RhRqnDs/N7fdcyE9Q0NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR02MB11889
X-CodeTwo-MessageID: 42dafd48-3299-4723-a54e-9b5b825f929b.20260930145704@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 ZR1PEPF0000E6B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	11af58ee-004f-4c2d-ee4f-08df1f03150e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|14060799003|36860700016|1800799024|82310400026|376014|35042699022|10067099003|56012099006|6133799003|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	5IZ8j/aR2/iDskMbB9Yh16c2y+i3afkRJAWgn9j5k3WyS76nvHxzV1q6rSBSzxhxB1pbPVQ3+jHloV3jx6jSNmEIkMBMu+aCoWgL3yG5wOoDvBPTQwXpWFB1auHarl4wephS9sJmx4yBAwW59genSKgkanUa3yPK0uBg/rGqyD6heYJpGNq8aRkiJCOieqRjny/gBtJDKPFnSRjxah3ABf3kZnQNaob7eIgh9Q0K3x7Le3Zt8K+VZHIeZpxE8C2e2gDiOzBfSmWCZ/mfzY3IribfXnJDrb1jzlS22f4WHGbb/HXi9T9xKwLfoFbY4YMjQoTpFQX92U6j/6mLFz7Vbx+jXaMhfSPrNz92I4TT55eue5/x45p4BxxxyK3V+O40jY2Veepwwd3Udie+GekUc3G1gm2BLlT2zaEn6FMNe+gN8UNbqUp5yu6EIyFuXxQCDrTAkLe7rmRUcAmrkXm09sY8rJR1pYjCSeJMwBCkuzoyWCf2PEtoCzt4N3k8oQLHzvYlkCTbnDlxU2igYPO+rVa1ZbExIhm6t1NYXRCvNQGp7cjZiXauiukWboJqkDEWAnlKUqxNHeT/KL46zmLvlUC8DkLBEXsk5in0fnWbdqf6tdlOq+ejspvRYMlpJnivHEYpt0tdj/4DGhCqKACa90fJQZwVZIfBkmGSLvftK6Q=
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(23010399003)(14060799003)(36860700016)(1800799024)(82310400026)(376014)(35042699022)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YNgV9iXhUlCY2qurHumEzruaTqqxywjrpcyZj4VR1NaF5eP5YTaSYLuwwAVtKAxR2FBcUALLCImEGkOW8pCbbLZYUEavMKM/wIC45Ix0ixz6AlLoewkHC7vnzo+zFr+xubBRloBi2S/VYnqdMZA/2QNFMqWarTNOe5trNjxI38RgRq0J2NXCIcyw5Rqtd4bRT+3ogFCBayZGOOpSXU89YeZbN0C8/qqzznkO8cWmDwj+v+BPJd8J/eof4lcgyB07mmEfIr6+HItKz5RV2pHKvTDfM1F7SIG8LXMXgMrq/fPUjaTwdzYmRe+WlWo4xZyITUC7kHacoqtYHYI/L7IHZEcb1Tzw1NXh4Eso/SPWS0wiEkFBpGIu5X5nSlkOMId/S5ACFtsFAdL6OADZShnMXxL+TFXVuyl2eheR8Ldd/mvRwGOg/oKXuMQhf4RKQsMq
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:57:05.2059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab649e6-3794-40e4-e25c-08df1f0317cf
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6104

This series follows the TX inter-frame-gap work submitted as:

  [PATCH 0/2] serial: sc16is7xx: fix TX inter-frame gaps on SPI UARTs

Following review, the kfifo wrap-around fix was resent separately as a
standalone v2 patch:

  https://lore.kernel.org/linux-serial/20260930143207.542930-1-paultyson.mb=
ewe@ziehl-abegg.de/

This series depends on that fix because patch 1/2 extends its
multi-segment TX refill loop.

The original trigger-level patch has been split into:

  1. a stale-TXLVL under-fill correctness fix; and
  2. a separate trigger-level load-reduction change.

Patch 1/2 re-reads TXLVL after each hardware TX FIFO write while data
remains queued. It continues refilling until the xmit kfifo is empty or
the hardware TX FIFO free space is strictly below the programmed
trigger. The hardware trigger and software refill threshold use the
same constant.

Patch 2/2 raises that trigger from 8 to 32 free spaces. This reduces the
TX refill rate by about 4x, but also reduces the time-to-empty after THRI
from 56 to 32 byte times.

The changes were tested with SC16IS752 over 1 MHz SPI on an i.MX6ULL
single-core PREEMPT_RT system, transmitting RS-485 at 115200 baud 8N1
under continuous Modbus RTU load. Each transaction used an 8-byte RX
request and a 255-byte TX response.

For the benchmark, "both TX fixes" includes the standalone kfifo
wrap-around fix and patch 1/2. "Fixes + trigger" additionally includes
patch 2/2.

                         before fixes   both TX fixes   fixes + trigger
                                           trigger=3D8       trigger=3D32
  SPI IRQ thread CPU          16%            15%             5%
  system CPU                  49%            44%            29%
  idle CPU                    36%            40%            52%
  one-minute load             2.04           2.02           0.99
  samples                     579            547            535

Comparing the final two configurations isolates patch 2/2. Raising the
trigger reduced median SPI IRQ thread CPU usage from 15% to 5% and
median system CPU usage from 44% to 29%, while median idle CPU increased
from 40% to 52%.

RX trigger tuning and generic RX/TX trigger configuration are left for
follow-up work.

Paul Mbewe (2):
  serial: sc16is7xx: refill TX FIFO below trigger using fresh TXLVL
  serial: sc16is7xx: reduce TX refill rate with half-FIFO trigger

 drivers/tty/serial/sc16is7xx.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)
---
Resent after fixing the mail configuration so that all CC'd reviewers recei=
ve
unmodified plain-text copies of the patches. No patch changes since v2.

Changes in v2:
  - Submitted the kfifo wrap-around fix separately as a standalone patch
  - Split the original trigger-level patch into a stale-TXLVL correctness
    fix and an independent trigger-level load-reduction change
  - Re-read TXLVL and refill until free space is strictly below the
    programmed trigger; use the same constant for hardware and software
  - Corrected the trigger trade-off explanation and added post-fix A/B
    CPU and load measurements
  - Deferred generic RX/TX trigger configuration

Link: https://lore.kernel.org/linux-serial/20260623112225.82386-1-paultyson=
.mbewe@ziehl-abegg.de/
prerequisite-message-id: <20260930143207.542930-1-paultyson.mbewe@ziehl-abe=
gg.de>
prerequisite-patch-id: c177f0e42a7122bbb1accf4397c73ccec4eaabb6

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
--=20
2.43.0
