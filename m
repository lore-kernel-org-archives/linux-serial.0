Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021132.outbound.protection.outlook.com [40.107.130.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAC2EE60A;
	Mon, 25 Aug 2025 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130140; cv=fail; b=De2Smu3hn3GG+VFha4uLvzwJIBZRrSBGcYAZA5b8Vh9XPB6JSumrQQ0qaYJnYAkH25KaM+4YhsUBHEifuwfqiX3aGNrgblk+cBhNgwN5n2mTYpxMoNvr+2lkq5KQdDYRWO1ksWx9rXFUchEAwx3h++ybBsHQ3+ckJfLb9y2Yk+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130140; c=relaxed/simple;
	bh=zLJ3XoPx+1PDfoTJwtXRU0NJ2OUamrhVW7vBcGS51SM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cyjS+XKH6HOTvmKqGRoOHWd5d/bNPMTdYVUrcR1EIxdRThHmKLZN6QMu26JmXYSU27FS82wZ9pS3ns8Ro/Vi0JGUquHpUCj+9+ZIY1K5eQIPSJMR7ZspYDYFMM4zc6UxwrdJduDOkNnWgycdZXrrWG5mf+DsiQUmoO5W+9Hn9XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nordicsemi.no; spf=pass smtp.mailfrom=nordicsemi.no; dkim=pass (2048-bit key) header.d=nordicsemi.no header.i=@nordicsemi.no header.b=fwRpN46c; arc=fail smtp.client-ip=40.107.130.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nordicsemi.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nordicsemi.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nordicsemi.no header.i=@nordicsemi.no header.b="fwRpN46c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIoluUttcVrxb0frFMkn7q2KLBFr2CzjZPewGSH2vJtLIi0O1Wy6/dqT/mlZAhwe8/5Z1dDhQX7zB+dvWzM0LOPjhUc5RI6d7ftJGwArQSQtKb7qkBpYktZY66CjEiBtMUS+6W8nZfP283IodFFbLCFA7RRDucV1GHOCoG8Gl0pG9PuM6Ro/o6GV7yI42THr5Z8OGfOHEHDh8DetGfvJkIeh/uunUm8Ehl4muR+Xso/zX/pAXwRcuqJZUws853BOEdIqZY6z2OlBLaeE4DJTdv+1g0jbhpyF5ebW4/snyj5jmpkVAR7OHTOYYrJiVm1DbdqHX6K5vhzcX/w11jVFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSx2fIYaCFRQ6cwxTyE1LYRwjnZOvxKySa7ZQXbosmk=;
 b=dply+MjXPHJK2i2Jrn95xU4NyGLIuRNrbNjVHOKg9/oDDOB2EaW7lngB4KVWhc2Tq8V+uwBKITs1JXWgcwrDe0JAce92cTqYQIRUqA2TZdE3QBd6NlYZj1eURVAWIyG7b2DeeZ4lE5Fzff7XO3CtKxmDnnIgTq4l3vzWhRdHSUhyAtU2m65wtQRQV9GaQbzaPM1pfZN8ve6OT4vUO9tzDhAnQMbovCFd8ygurcFW72QMeVvEUwkXxxPxRKIoGIV4HznLLf+j0rgUZ5aUhwXDtCCK4VJzIGGUqlgDle7CK76XEmCYE+D4SLgn70BX1bE8gpxDX3p63ez2pGEYgsgn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nordicsemi.no; dmarc=pass action=none
 header.from=nordicsemi.no; dkim=pass header.d=nordicsemi.no; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordicsemi.no;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSx2fIYaCFRQ6cwxTyE1LYRwjnZOvxKySa7ZQXbosmk=;
 b=fwRpN46cKHieDAYmyhNUMqo2DZWEcm+yYVagFp83iSDwNLe30d6Bs7KCVc/BOaEWMd7dzpIPu8cPJG/6k38gN3mqStFpUgJrHQnkdPJuwptKJCVbCDG+5aoQ1nJJwZiiIm1ILWrhhGyXyib3L1cj+d/QQS6QDSvUfuM+qs9QbTEmldx7i3gxbobhz4JOXnD4eXIzssFuyVCC55USB3fj91K3U9FfnkQfO9LEXR1g84zhZJbkgS+55gQdcBnGK+/4/laKTW/sRrWtx/yjDCPZUNNvceNuMFH4JDLwsDXPc845NuEvjEZYtf9TBaz99CZBclxJRKukMZw7MKp2DG0mOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nordicsemi.no;
Received: from DU0PR05MB8949.eurprd05.prod.outlook.com (2603:10a6:10:354::19)
 by DB9PR05MB10252.eurprd05.prod.outlook.com (2603:10a6:10:450::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 13:55:33 +0000
Received: from DU0PR05MB8949.eurprd05.prod.outlook.com
 ([fe80::a522:c95:5d9c:15e8]) by DU0PR05MB8949.eurprd05.prod.outlook.com
 ([fe80::a522:c95:5d9c:15e8%3]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 13:55:33 +0000
From: Seppo Takalo <seppo.takalo@nordicsemi.no>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Seppo Takalo <seppo.takalo@nordicsemi.no>
Subject: [PATCH] tty: n_gsm: Don't block input queue by waiting MSC
Date: Mon, 25 Aug 2025 16:55:00 +0300
Message-ID: <20250825135500.881285-1-seppo.takalo@nordicsemi.no>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR08CA0072.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::43) To DU0PR05MB8949.eurprd05.prod.outlook.com
 (2603:10a6:10:354::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR05MB8949:EE_|DB9PR05MB10252:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2f12c1-3134-4e47-f55d-08dde3df0f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?muNeW3EktZcDnX6tVYuw+uevGVcXd0g+XasgHmC8nAz8TGsucpbeJQssN7Vb?=
 =?us-ascii?Q?411YWIcyRJc2zYTyn2c6Fqu0hxpslxqEqnJBWuqIWvvIBSqWAdMeAhyampUc?=
 =?us-ascii?Q?1y79l2yStamXRKRKnVB1+TeZSLMrCynY6UEEiw6J/FbRpeHL3LHW1n+uVVfS?=
 =?us-ascii?Q?vrTkHxrxoPCACuAVDkoiqC1e5SSsxE81waZkAVpCJSA52n5kEf6mdy6TAlHF?=
 =?us-ascii?Q?hzNOwD+K+z8VzTawcmjuiWPSWDiSOglg+WEQ1LzOtwkO2pjes0hvaKzU/oWb?=
 =?us-ascii?Q?S9mh3pbE8S+ljT+zxmQkr82Un2qZHzY8y8hmymNfNXeRayw9gj4I8YiV10Cm?=
 =?us-ascii?Q?VtWuWV4irUVw3ZVPSqW+6LhYtR3RqhxXgD+Va0y33RXSLdj/RLCnxWXD9E7l?=
 =?us-ascii?Q?cueBknTHiNeFtBYbiT0PzHOrtG52jaIna2Mt2dKEw2PUcUqdNnGF9r7litsz?=
 =?us-ascii?Q?sPajA2gdv9q2jXJTPmpg6nzjA/rIMxRIm8qQlt6X8ROWnl7dXFEi4Nm85jGv?=
 =?us-ascii?Q?1ufNy+G6A3r1u9JDi/K81Vqe/yEF80wbsElmPCzqo0Ho7kUFveRr0dXqRRAJ?=
 =?us-ascii?Q?3zcPXwtG2AeqnsNBqMKN7B6mDPcVf4uf16JE6D4btw0m+TVQhHzJg7v+C+Sf?=
 =?us-ascii?Q?WFvzTP0q6m44ypNdOrltnsmUBBj0Svp6AT6QjApx0b0XnKZmjuayCOlDineY?=
 =?us-ascii?Q?3HK4cEyV8maP4X2ceIft7d7TjQ9Gj4cPvndywOrQU7gSgO7RoFFCYrQpzIFE?=
 =?us-ascii?Q?SOEhPyfI2zMIiPsX/XBtGtGRpHKtZcgMDGFdKidb9OmEfMIjol/WLHBMAs8F?=
 =?us-ascii?Q?9+YVGEAITytYnTsNohhASu++jl5voyOPX5l7vWdFYvwwyR0zN1kMW2OHo113?=
 =?us-ascii?Q?n7XW/WXpnYs+3os4OACFtrjcxNyRu6xktrhZopA8/wn3C1+by5GB3TUts44A?=
 =?us-ascii?Q?ph6rItEYNSsnGo7CaJhaxPMoTLvYlLmRMZV1adv51zPuExrJNBYCrozM5Dpy?=
 =?us-ascii?Q?P5KdOUeAhS+b7eduHu7IAqSItT8nVAQTL9Swi9mcF/a0faazpDa6y7eT8lVz?=
 =?us-ascii?Q?tPwrAtFl062lQYv1jdcuzo4lqdo4KMInITTHorl7fjYsU7SwTwsLIFmuhUnP?=
 =?us-ascii?Q?SCh5LZjqhDg3PwlO66Lq3RFFRBtFJLHT8bh56WhMw0X0h/AQFihsxP8wbwpM?=
 =?us-ascii?Q?WiMbjBEI8NCr31voSgxMu1DVc7Ks0epokt4j8mfPL6c2ARLToIELk5ufV1su?=
 =?us-ascii?Q?Vty0XjQCdo6UHlXsQlsBgVKihAE4EkcTA0UuaOLAV6KVfwgQ2Otpxjtxn0J5?=
 =?us-ascii?Q?lPA1oYn4M32CE47dAsD0Iz8EqoQPLVhEs95bAsOas/+JZ8NQoBZYGfLkUrQb?=
 =?us-ascii?Q?P1eBOsSc2135VR+NAwmNSvFykGnv6rtH69VlYDaBINjCXCt+D/CU2MrRydnr?=
 =?us-ascii?Q?gBT5jEVQw6E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR05MB8949.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4GsQ0tYnZ6bmIPtuC2fGI+1nAnFvRoDQeJCL6Y6msH1fi2eKVkGuMNu8v457?=
 =?us-ascii?Q?AV+n0R1U4PZpFPgoTBS2sbIjGWnHwxa+1zGSpH3M830EAOzhuh3CveyNoefp?=
 =?us-ascii?Q?g34fZb3dw3zlJbxE1iTSr31/gNuqb17QU+e0lXj9sUson37D0KY0C28/WcyG?=
 =?us-ascii?Q?l/SbMUGivNeMwAkqOTKE+7bh+TuTvNn33IbQaMGRUNbbq75sndE9gYFf0kCJ?=
 =?us-ascii?Q?0pPFUr/GeebkWF/A61IBHc5wjhTIAQPevRZPqNhCu4ZwJrY/qMIzXhbONAF8?=
 =?us-ascii?Q?3EwivtK8NbGIiSO6KaYgl0d6AYrR95NiaiwesdfeN6swMpQd9d4O1Usvh0cS?=
 =?us-ascii?Q?9ZKG/IOqcrNCeD1wQ1PWUiTwDTF1ywUMA8eM0cjFqUFtGEuVOJjk8RpyW7iA?=
 =?us-ascii?Q?3czmx5yKr0Yfs6d4EkSPsUia5SENiZCYhc8x0cpix3dIgLljf+s1cEV2MWTs?=
 =?us-ascii?Q?oIWAQabd+SAIEc1A1fdawaBpCjjH5ClgkrcxKreLBrqg2IAMn8G5tNaikuo4?=
 =?us-ascii?Q?hmoDR8nSdesOFnj1YfF/w7qZTgwyQVHRaaVHQkEdXRqum4lAIo+pJWqKMdDd?=
 =?us-ascii?Q?8Ljxx/5H96Y5LwzgNgaEqyQVrQMaFBXBhscYx8XFYk+rBnNjTQDFvWCc2+GB?=
 =?us-ascii?Q?Kr8iA6+j+zA14Q6/amJ8pMm5ria+AmcV0nEwdiVQwpbticuuc+ucZ1XOfPZp?=
 =?us-ascii?Q?4Dc+2OnF10l0F+wbDqvxZhSBSRYWK6JUNHzjoat3LIq2SUbYAwFxpw1hxdzn?=
 =?us-ascii?Q?5GN+iqtqJ6AVob2hC5nAxoN/NkJbMWHfIM5WHpyaf6dxguWyd9JN7JszIscD?=
 =?us-ascii?Q?EXa7efcfvXxUbvud32whg4TNikPJK179Jsm+vReFmdiooAe2IJHlcd0ojWJ1?=
 =?us-ascii?Q?Y4avaME0HE8rpxD4YsEEYcZdQpvQAlws5FXtU3TleRG+/2XcpMfnAidP/8sY?=
 =?us-ascii?Q?1cIV1uzQ/P7wXhK1IYimNepFgQSa5CcBIO3Bk1Fd0BzgcNw35LKoaI2vCNlp?=
 =?us-ascii?Q?INcHYN4p8p28CkiprRLYcUT0f8obdchyDqA2qCxMdQTR5YQU3NVEyV4T65lP?=
 =?us-ascii?Q?LiXET4q2FfEZxSV0ZPpuq5fjM8JbbCK+fDPgptLrZ8t8oL9H9JkvnSpuMzYw?=
 =?us-ascii?Q?bj75kPa+Jv41ZK7RPggjTvB6kGn9xXlMRR4HbLHkYkghoQa7YeMhCxR+mxzR?=
 =?us-ascii?Q?bd8QoeP/wf3drH/WCXXt2PorEiRoQ2jflTvpRYRNeb9RFReLvdMti4Ud+110?=
 =?us-ascii?Q?JYRMd/SsvpUHMbO8xgeEWe1nN4QuhyKwP9y212SGEaBRuPRJtkY7SzxqE5oD?=
 =?us-ascii?Q?esSFqIn6oZqOnVWM6uMyOlUa9kuR23BH3+zSe2CuUUVUy9377r6VLpUN5FXa?=
 =?us-ascii?Q?s47pi+GyiUIFZeWwrnZN2+JwoMsk8W/oNTQVPjj9DxMc8L6ZtMA2D+Px7Btg?=
 =?us-ascii?Q?WImddWb7Y7QuMKp8Tdita7p5GarnwNSDKHgKjOd9CD4OREY1XT4EabunfT1t?=
 =?us-ascii?Q?9K7z/OOaX9vK5IetTVSC2c/klp5vVRad6t5X5Ouu/CecKcBPE2Mks+Udp8SD?=
 =?us-ascii?Q?/3YVOJDTHwRMX2WecfTGLGpjlVStA8YEAFnYRZk2Dvbah74pYOFx4/gJVz2L?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: nordicsemi.no
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2f12c1-3134-4e47-f55d-08dde3df0f32
X-MS-Exchange-CrossTenant-AuthSource: DU0PR05MB8949.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 13:55:33.0824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 28e5afa2-bf6f-419a-8cf6-b31c6e9e5e8d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lqwVfhv/Q8JDA8iEdFpGaTijspC4EaMkCkDP9p7rvDuL7IU0mOIBY+p4MEFGdlF/APFAvDD9140bJ/0wPH5/Ds78ViIbcZCJ0sR7j/EVmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB10252

Add parameter "wait" for gsm_modem_update() to indicate if we
should wait for the response.

Currently gsm_queue() processes incoming frames and when opening
a DLC channel it calls gsm_dlci_open() which calls gsm_modem_update().
If basic mode is used it calls gsm_modem_upd_via_msc() and it
cannot block the input queue by waiting the response to come
into the same input queue.

Instead allow sending Modem Status Command without waiting for remote
end to respond.

Signed-off-by: Seppo Takalo <seppo.takalo@nordicsemi.no>
---
 drivers/tty/n_gsm.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 8dd3f23af3d2..8e8475d9fbeb 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -454,7 +454,7 @@ static const u8 gsm_fcs8[256] = {
 
 static void gsm_dlci_close(struct gsm_dlci *dlci);
 static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len);
-static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk);
+static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk, bool wait);
 static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
 								u8 ctrl);
 static int gsm_send_packet(struct gsm_mux *gsm, struct gsm_msg *msg);
@@ -2174,7 +2174,7 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 		pr_debug("DLCI %d goes open.\n", dlci->addr);
 	/* Send current modem state */
 	if (dlci->addr) {
-		gsm_modem_update(dlci, 0);
+		gsm_modem_update(dlci, 0, false);
 	} else {
 		/* Start keep-alive control */
 		gsm->ka_num = 0;
@@ -4138,7 +4138,7 @@ static void gsm_modem_upd_via_data(struct gsm_dlci *dlci, u8 brk)
  *	@brk: break signal
  */
 
-static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
+static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk, bool wait)
 {
 	u8 modembits[3];
 	struct gsm_control *ctrl;
@@ -4155,10 +4155,15 @@ static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
 		modembits[2] = (brk << 4) | 2 | EA; /* Length, Break, EA */
 		len++;
 	}
-	ctrl = gsm_control_send(dlci->gsm, CMD_MSC, modembits, len);
-	if (ctrl == NULL)
-		return -ENOMEM;
-	return gsm_control_wait(dlci->gsm, ctrl);
+	if (wait) {
+		ctrl = gsm_control_send(dlci->gsm, CMD_MSC, modembits, len);
+		if (!ctrl)
+			return -ENOMEM;
+		return gsm_control_wait(dlci->gsm, ctrl);
+	} else {
+		return gsm_control_command(dlci->gsm, CMD_MSC, (const u8 *)&modembits,
+				  len);
+	}
 }
 
 /**
@@ -4167,7 +4172,7 @@ static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
  *	@brk: break signal
  */
 
-static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
+static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk, bool wait)
 {
 	if (dlci->gsm->dead)
 		return -EL2HLT;
@@ -4177,7 +4182,7 @@ static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
 		return 0;
 	} else if (dlci->gsm->encoding == GSM_BASIC_OPT) {
 		/* Send as MSC control message. */
-		return gsm_modem_upd_via_msc(dlci, brk);
+		return gsm_modem_upd_via_msc(dlci, brk, wait);
 	}
 
 	/* Modem status lines are not supported. */
@@ -4243,7 +4248,7 @@ static void gsm_dtr_rts(struct tty_port *port, bool active)
 		modem_tx &= ~(TIOCM_DTR | TIOCM_RTS);
 	if (modem_tx != dlci->modem_tx) {
 		dlci->modem_tx = modem_tx;
-		gsm_modem_update(dlci, 0);
+		gsm_modem_update(dlci, 0, true);
 	}
 }
 
@@ -4449,7 +4454,7 @@ static int gsmtty_tiocmset(struct tty_struct *tty,
 
 	if (modem_tx != dlci->modem_tx) {
 		dlci->modem_tx = modem_tx;
-		return gsm_modem_update(dlci, 0);
+		return gsm_modem_update(dlci, 0, true);
 	}
 	return 0;
 }
@@ -4531,7 +4536,7 @@ static void gsmtty_throttle(struct tty_struct *tty)
 		dlci->modem_tx &= ~TIOCM_RTS;
 	dlci->throttled = true;
 	/* Send an MSC with RTS cleared */
-	gsm_modem_update(dlci, 0);
+	gsm_modem_update(dlci, 0, true);
 }
 
 static void gsmtty_unthrottle(struct tty_struct *tty)
@@ -4543,7 +4548,7 @@ static void gsmtty_unthrottle(struct tty_struct *tty)
 		dlci->modem_tx |= TIOCM_RTS;
 	dlci->throttled = false;
 	/* Send an MSC with RTS set */
-	gsm_modem_update(dlci, 0);
+	gsm_modem_update(dlci, 0, true);
 }
 
 static int gsmtty_break_ctl(struct tty_struct *tty, int state)
@@ -4561,7 +4566,7 @@ static int gsmtty_break_ctl(struct tty_struct *tty, int state)
 		if (encode > 0x0F)
 			encode = 0x0F;	/* Best effort */
 	}
-	return gsm_modem_update(dlci, encode);
+	return gsm_modem_update(dlci, encode, true);
 }
 
 static void gsmtty_cleanup(struct tty_struct *tty)
-- 
2.43.0

