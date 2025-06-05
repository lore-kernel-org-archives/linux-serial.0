Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C8C1DD0D4;
	Thu,  5 Jun 2025 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749101357; cv=fail; b=LfwClPm9wJGMwEzOWgSAjI5CDK5vYlA4yp6X3iD4oV3FMeSChmZITs5N2Zgz1o4m0ZhPKdyuBwd/IlHyMOHyNMrAeCILCKdKBqNmvzXocZDXcG0KwPjyeMJd933zkqyQT+P5IOX+4pAsn1pphYljDp5+VmJhYUIO11U37mL/6io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749101357; c=relaxed/simple;
	bh=4WacdIv35+wOp98dew2rNUvaZoWPGatNnN/MLLZH6Mk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cfnmB18NmGIGSUtmTLym4iN+QHf5JSRyHRJIz1KIIWHD7sZx395wUX2/fiu5coKkr5X6M5XF6YJzj/BNMSARhNjnd1Uw0sd7lCb1mZDwMxcO1ro/gr0NWPW0J1yrT1MHHaWEXiNljvaK/FMNyqttYFU8h58kdwKP2QytAl1FgMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=bsf6NewJ; arc=fail smtp.client-ip=68.232.159.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="bsf6NewJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1749101355; x=1780637355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4WacdIv35+wOp98dew2rNUvaZoWPGatNnN/MLLZH6Mk=;
  b=bsf6NewJKXhxQiThKYi2HKhj/5iW/O0WSP/DdOhJu8GeSDg3B+Cj1Xbh
   Udk7RCQrjY6yUKokY8Md2I1nD9ODWUXdNONasedOyovaS8tYF1KUpM9ox
   PEGihVllgCe7k/e2W7WgHh3HxVnFV2jBtSu5GD0ymLUKLQooajJrO8yIk
   4aXu1Wixbf2BUs2blPFJkuFdhDwr8jst1EhHnZr2QViNX2Mrurcrx2VlW
   ZsDqT0U/FqyAKfMNfIKLPbO0ZSnAK/DIgv5Y5lsYtH0i1XraLLqXpJ6Va
   FN48YQUwy3S3GOzyf1rg1oS3p0o9vGzc5U2knMeRwjfwk3vRY8Uwkt78a
   A==;
X-CSE-ConnectionGUID: wOqpEzyMQHOXeb0vh8TE9w==
X-CSE-MsgGUID: yUr2hx9mSpOerSS9v5jrHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="157654801"
X-IronPort-AV: E=Sophos;i="6.16,211,1744038000"; 
   d="scan'208";a="157654801"
Received: from mail-japaneastazon11010016.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.16])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 14:28:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keaqVbbMxRtvgevSXaQdugwQKVFFX/TfmV5nUILGjsbBjD2AQmobAm9JNL0bANAGAtYQAm1XROgSGKK5W0lC3mtSQuopdh4x0AEzOhtvB4O+I+ELpyiMgtuyvxE5ppw92uI5LOWxgmrpj7FiSF/d4U4CXy4YDo/XYykAIScuxCwJTxOTRNYc1HgFoBlYPf29EqYXDQPFm3pQ6KCvAT3plSI6u4adGqqokPe6QDX62FN+RSlHTReob81UgSOHRNDdpLh2wj+kQR6Zi0hcQ6snFKhMzPhOrw9Zxy/Tl5vr9WSINhWfSPl4kcqFT9wfTzMGPgJDN+P1KI8sArvYaKm99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+CS9X0uJhb8QJM2GuE1aLMDLzTdSPOhixu6ued5Dcg=;
 b=yb5m9Ex6KlHx+ZEbWToJ581Noz4qgCbW2UE/w6X655rd/SYgaL9EbkuA6FFIhQ/Dl1JoQdHE43CAzglkkzbsE7Vrkdu5IG2fRRTG4jxRAho4s3werPRd4XRwAX55yTAv99/haGavCsz8920QQW57zjqbJHurmfn4cY8Pkqx1wFiHKgU1yLHcokN5yteaOFN/7cfUVRYQO5MDOM4LpiIOkbhvVDQtorviWHfubz24PpxJWqlXK7R28xltJSqnVCGkZrXFosZdwHCVoQNo7iXkHkBCklMVbk1xQrO8c14uoUjDIpKJfAfX5B+S+iMuwjHpQ0cGpSnreQLnYEVna2grww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com (2603:1096:405:1f8::9)
 by TYYPR01MB6761.jpnprd01.prod.outlook.com (2603:1096:400:cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 05:27:56 +0000
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc]) by TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc%7]) with mapi id 15.20.8813.018; Thu, 5 Jun 2025
 05:27:56 +0000
From: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
To: 'Petr Mladek' <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>
CC: 'Michael Kelley' <mhklinux@outlook.com>, 'Ryo Takakura'
	<ryotkkr98@gmail.com>, Russell King <linux@armlinux.org.uk>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Toshiyuki Sato (Fujitsu)"
	<fj6611ie@fujitsu.com>
Subject: RE: Problem with nbcon console and amba-pl011 serial port
Thread-Topic: Problem with nbcon console and amba-pl011 serial port
Thread-Index:
 AdvULbS8DdGjT9TLS9OOSVhbv2AtDgAN1+gwAALFDgAAAfWTAAAeB8NgABQ6MwAAAXadAAAD5OQAABRXfIA=
Date: Thu, 5 Jun 2025 05:27:56 +0000
Message-ID:
 <TY4PR01MB13777CC92C858572B9C19394FD76FA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
References:
 <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de> <84plfl5bf1.fsf@jogness.linutronix.de>
 <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <aEApOPTqbVOR35F_@pathway.suse.cz> <84o6v3ohdh.fsf@jogness.linutronix.de>
 <aEBNLMYVUOGzusuR@pathway.suse.cz>
In-Reply-To: <aEBNLMYVUOGzusuR@pathway.suse.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=f68cbbd2-6115-4122-99d1-407f6af113b4;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-06-04T23:30:40Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13777:EE_|TYYPR01MB6761:EE_
x-ms-office365-filtering-correlation-id: d5daddf9-9d8e-4e6e-f465-08dda3f1ba57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?eW01aW8ycUNnelNZUkdJTDlsWXlBekJscDJ0ZzE5MlNqWkFTdXYrdGlz?=
 =?iso-2022-jp?B?ZElXRDloK0hWOE1qWEplV0RuY2VkVmhDZ0plSWxZS2hYcE84aEVVaHZT?=
 =?iso-2022-jp?B?MGhXcHp1dlpQaWxXU0tJQlFVTXF5RUpSeW9KaFlic1RPRGs0WEw1d1F1?=
 =?iso-2022-jp?B?Tk5sUCtMMldNdGtkN0k5aVg3T3Z5SURmRFJFek9UL3NreldDMDdjalRQ?=
 =?iso-2022-jp?B?MlRQaW93SmM3K2ZFcnM1bXZwd2JiOER6RFI4ajZmQmRjbkFJZmtHL09m?=
 =?iso-2022-jp?B?dlBwOEFlWmFSak8zck0vWGtmd0hGa1NOTThib09BekxRSmxYT00zVmRs?=
 =?iso-2022-jp?B?VTRmR1NJcWhVMGtFTHo2bWdYbkNlbDQyQkFHYmJWVWE5eHhaOHhqTHh6?=
 =?iso-2022-jp?B?Z0tkaFkxRk1lTmZsSHR2S3RBL3lKOXRpVXN0QklIYlU1dEZtcEZCRTg3?=
 =?iso-2022-jp?B?ODVSK0tON3p5b3RVM2ZtcC90S3gvdU0zL0NVYkV0akp5cWRESzVEN0Jt?=
 =?iso-2022-jp?B?cHkzS2xUYlNwTWRtYW1zcnV6N2ZjQkxOVFBIMUVzeEFaU1VRSTI4L2M4?=
 =?iso-2022-jp?B?TjhJMnp1QjNNcTl6Z0pTR3QzY0R5b3Z2a3RBNlRweEQ5ZlJ0LzExeVVH?=
 =?iso-2022-jp?B?WXJ2UjdXcWp2ekVpV1B5S0VCL3JBOHU5T1pWRnNrZjFPbExNUlpSYllV?=
 =?iso-2022-jp?B?YktpSGVlc2wwM1ZYVUl0MDc5Y1FYMnhqTHZDVkNaWWp3RmtSRk9DM2ZM?=
 =?iso-2022-jp?B?cWMxaFFXUyt4azJjaXBwVHRicGpHMkFnbWRaaSsyK0JwdGF0WWQ1Nk1L?=
 =?iso-2022-jp?B?eFQ4Umc0SmJTRjJxTFB1NzFOd0lvS1B3ZjU0VTJTUFpheEJnaTIvQllk?=
 =?iso-2022-jp?B?dmgyOU9Zb2p2MU1sN1RTbkR4TENLdXhxMnZJc2dQUlhzbnZQTGFVQkpy?=
 =?iso-2022-jp?B?UXFSSTU1ZDBvcUxIMjRQTGZnaXc0K1RLMVJEL0dyc25hZkVkRThLbVM3?=
 =?iso-2022-jp?B?WGhXN1c3eFlVcFVmNk5RRXJnWG5iQnVvRlVMQWs4V1dHeTVFais4L2Nx?=
 =?iso-2022-jp?B?WFJhT0xhTisrL0RuRCs0RklhZUxDNy96MDVMUDMxcXRqT3N0eFpSNDR3?=
 =?iso-2022-jp?B?MXF1L3VsY1RZeUpTMU9uQmFndDRKZzd5eVZBVGZnY0lsRWdVSXBxNHRK?=
 =?iso-2022-jp?B?NXBYS3IzMDY0eGZaT0EyVVN2M2RkSVEwaDFISVFOT29FdHRmYm5mcmgx?=
 =?iso-2022-jp?B?UjN0a3JIVkJVRFArbVU5MWNWSUtieWhQMHFSOFlGZGt1T3pjNUxJT3pj?=
 =?iso-2022-jp?B?UTE4YWFrZ01kemNBSHRyN3JrbW5KUjA4T1loMUR5YkZRNFJhK0dXTEZm?=
 =?iso-2022-jp?B?NHB3K054TVluYTZyaFNqaWNoaUI2cXNKd3o5NzkrUUtURUV4WHY0UGpp?=
 =?iso-2022-jp?B?TGdFS3E2S1ZEdFlMRDRuWFp0bE1GUmRZRnBMVmZGczRHRzJuaEdsdDBj?=
 =?iso-2022-jp?B?NnYvdVI5VEVRQ1lTWFpYb0pjSytLV045MkpMVWs3MDRwL0ZqT1pnNHc2?=
 =?iso-2022-jp?B?UUF4dEc2OWU2MS9LL3YxWUdHa3dDa2Z0SWlNL2FlcGI5WnJHYWhDNEc3?=
 =?iso-2022-jp?B?ZDExS3BWQ3p6T00zRGx6eVN5YTdrVzcwRXVjWnFILzFhVHlwY283RDI2?=
 =?iso-2022-jp?B?Kzh2RHJ4M3Ard3ZSM25ScER4WWw5ZlVCT3cxUmJJbWNuZkk2V3NZYmtX?=
 =?iso-2022-jp?B?Rk5WbzloS0EyWDZCMFd0aWEyN2FwbWpKRTExT3Nsajl6Tm1WTzdkeUJ0?=
 =?iso-2022-jp?B?aWJsdVRZUTlZRHVBcG82eTVHcFRmNU1Ra2hSblpZWGV4TDF5d01TSzNM?=
 =?iso-2022-jp?B?MENYWXpCeTAvNWdvVE90Mk9OaWxKdmxaVnd6MFgvUE5sTTlpcFNrVmVJ?=
 =?iso-2022-jp?B?YmdoektmY2dzZjNKVW9UcXFTMVF3OGFqa1lrMWRTWmJ1ZXFEdzdtOWlU?=
 =?iso-2022-jp?B?ZkVQUFRWOXZGSTFEY0tWckRvamRHVjN2Y3Z3VXZSVUNXSlg2aFhpM1RV?=
 =?iso-2022-jp?B?eW9id2daM1RQZjBFRnhPWmFkaGdWWmFSK2pjVVFiRTVicFRoRUlBWmdV?=
 =?iso-2022-jp?B?ZE9rY09LY2tFVG9pcUd3TzUyZWR0WFNqem9LcDFjelJmUllQSFhyUkJw?=
 =?iso-2022-jp?B?V2VWVldlc3czNzZyVEI3UzVZclIzZk8r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?c1FldkdqNnJKVDlrMVdLRTFKaGxOVTJHZWM0VjUrbWIvai9nNExOK1NX?=
 =?iso-2022-jp?B?K1BSMjB0VjJiUnRpQ0NGUjBxOEtFMjI5MkdiZ2pVUEtBRmIybG1IaWZO?=
 =?iso-2022-jp?B?bkdnZFNId2t6ODFLaW8wdDd0VVNUbm91RWcxN2Z4allPRlA1V3YyYXky?=
 =?iso-2022-jp?B?alZMS1Q4bzlIRjc0cGZzNjV3YVcvbWRwZ1J0OE9SVjVmZGVjcXFzdE1T?=
 =?iso-2022-jp?B?L2VJcVpvSkM0WlFDcEZqaXpSRXhic0U0VWFQbGFuU1JLekFmNHB6dXM4?=
 =?iso-2022-jp?B?ZXBTY3QydDY5eDJHR2pKTHE5VVFoTkFGTFl5YlNsTnVXL3NGZ0ptQXU2?=
 =?iso-2022-jp?B?bXZWUDA0UE5lYmhlYkxyd0lUU3BYK0M4dTZHODU0OHF4YlZmVS9sOCtj?=
 =?iso-2022-jp?B?RGc4VEZxT3NIRUlFdG54WllhNFAzOUUraHIzL0pGTFZOS0JaeTU2cHVY?=
 =?iso-2022-jp?B?ZnRQdy9HNnVmV0p1UUF6dnp0REV5ekdUWUZEKzRQZ2Y4QzY4Y0duNHdq?=
 =?iso-2022-jp?B?WGlvazVObWpoYzhib1grUG44V0hMQXVWNTdmT3NQRjRFUHpnTjZvSG40?=
 =?iso-2022-jp?B?V0REY1hTL3NkLyswS1l2V3FjZWJEM1ZKMWQ3a3VLWG5ZS0hwQTA0bTRQ?=
 =?iso-2022-jp?B?d2dyL3ZpeHVVOGJwbG9UTDVhTjdocDdWcVBxRjI4WGdKZkVHUm5qR2Na?=
 =?iso-2022-jp?B?Ni9vZHNPdXJBYTY2TUI1dVd2YkR1bk8vMEltSGZRSjYwOFcvR21zUUtD?=
 =?iso-2022-jp?B?T1NyQzF3b1AwcVU3eWVLeEN4K3krVzlCUDlrbFlMWEhOdXFqYkY4TC85?=
 =?iso-2022-jp?B?QUY4REV2N3lHdlZBZndHMi9RMDlPQzRad2x4WThycmFJMmZsd2xuaTZl?=
 =?iso-2022-jp?B?M0djYzdscUNDY0IwTmdwMGRsWXMvTGlvaHVBQnZ1dTE2Skx3ZmxBYUxV?=
 =?iso-2022-jp?B?RlovNDNsTWNGRzRIZzFTZGlHOGY1VVNjbnBtcnlYOHN6YkZtcjdsZ3BV?=
 =?iso-2022-jp?B?NGVXaDZCOHlzN3dQZ2JxcUYvT01od2x4NHhWSFVzenN1OS92dEl5cWFS?=
 =?iso-2022-jp?B?eTNnTXBLdUhPWjJKcUFFQmYzL001eHkyQS9JWW1oRjJNUmoxUm5HUmhn?=
 =?iso-2022-jp?B?ak41Z20yaFdtdE5MRHhuMFhxMVZkUGREZmpGRWNiR1kwL3U0b2M0eTBI?=
 =?iso-2022-jp?B?V0JqQXBhU1pBQkdBOC81OWVHVUZmeWczczNKUWtqR3JqeVRtSmExY2dt?=
 =?iso-2022-jp?B?WURRYWVFeE80WFEyWWZ4VG14RkwzSk82NEJqMzNWMWlLUEZUNW82UGJ6?=
 =?iso-2022-jp?B?T0JQM0RWb3o3NTVBUGJpeGplaEpucUF3VTNuR1FjdTgrcnQwc0l4TzR5?=
 =?iso-2022-jp?B?YlB5aEp1dUpPNmtOZ21URjB5b3ZCSFJIcTEzNTJWL3Y2WnlSc0ZhYkFG?=
 =?iso-2022-jp?B?M0lkeUxlbUszNTEzckpLOCtmSE5lR0E3YUswaGtrVFZpUmo2aVZ1UTB2?=
 =?iso-2022-jp?B?SU5jMXhncnRneXJNRjZhQWtkQ2VzTzJ4dExhNkhpazNzWEZhbDU2eHRh?=
 =?iso-2022-jp?B?WUo5ejF6MkNJMlluOVBxK3ppcXFPNXR1Qis2M2xEUjVtbFJuUmE3SG1U?=
 =?iso-2022-jp?B?T05pUGJmZFVraGErU3YvaFFPMEZ2QitaWGVGN3dDdlpMODUzc20rRzlv?=
 =?iso-2022-jp?B?WGU0bDlMSDdyaUNqTllLSjhkV1VuUmh3WXQraHRvVXVJNm9nM2NtUGYx?=
 =?iso-2022-jp?B?enVxdGlzT0RWbHV2QUJIK0x3WFU3ajFkRjJac2l5YnRHeTVaeFJCL2V1?=
 =?iso-2022-jp?B?MEl1dXR5L1h0VlNWVDU5UW5OUHNtUUZjbjB4cHhhTWV6U0pkdUxxRm91?=
 =?iso-2022-jp?B?cnhicDVxekVyZDJzc2dpa2dKcTJEeXJFYS9Rb0dDa2Q3UXBvRzN2MDhm?=
 =?iso-2022-jp?B?S0N6ZTBCcjMwMjQ2UGdYand5M0xaSW1LbmpjSVpxdHFzbE4wMGpac1BD?=
 =?iso-2022-jp?B?MmMreG5ZSGhUTGFyZ3EzdUpleGxUWnhEMDdLTWFwSTI4T3VMWVVNVUxD?=
 =?iso-2022-jp?B?cHlteTFLNFVMVEVtYjNqa2NpM3Nhb21WWHJoVzZPc3pTem0rVzlJb01q?=
 =?iso-2022-jp?B?OTVrZERENk14bDNYVm9iMHArR2hRZk1VVUVKUkMwL2xzeFYwbjRIOUM1?=
 =?iso-2022-jp?B?TmJMR2M2YmVhdDZBOVdzSzJsbitOL0RDeVhWenYxdWtnamovaWZTdDFM?=
 =?iso-2022-jp?B?eU9HWjJhR2hLby8yOTJ4TitOQzFxcGltbFlIRjJTZlBOekMzcW16RVcv?=
 =?iso-2022-jp?B?SzZTbkFleDdsWXVmQzlPRUpCOUlVK2JPWHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EUiOUkhy/jENzmUhuZ008D4YlGGCJz5pBht/5tf9Ckd3JsqVeo3sd9tL8pr3T/L2thp5XOhtginHFHa1Gc/Ztm2bjmd2BfIysxkF4OVpQmIw7FH/NtfOI6RTfF3wte6n58BKF+Pu80OC4U3fEoslY5dErOtKKaC6nTWljl+pzGHhscwDBO85C1PDDmMMPKn3vzzuNZHiF3KIpw99HeN9IwEeMQ1Xkn6HQfQaJDYT17tv+A04n4ELDPtlDTQkONK1mZJd0N5Z0f+eRSPkfeOj82crH2O5OuHkutwHiwq8OzOyhttCv4rm/PKqtIrbzGPT0e4C72KuNZ2Fcdh5wtERbQ66CaJZDctvBUGsX41oC4gG6exSC9K/gykA8ZwaYpD+Y+xBxJtB9MEKYHjnZ+Pf/Mjmg22xLZs6TU/wX54Ze2rqFNSz8cBrxviPAzfsbHsUuJqraMgEm78bh4vpd9eom50dE5QwahgIXMx5BpNFIhzsOB513IN3dnY3hQFtBrjSV+2n3yVJqRQD8kVWme/fjVTmjNUnCcZ7aBvJBIUZk2EnvaNgQwc6sCzqKYncmemvCgvl17OazeVMfDeEkXh8AmO/xwRDU0s6EL+vhPOWgygNXbjlxd5+nBQibjZSdy6H
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5daddf9-9d8e-4e6e-f465-08dda3f1ba57
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 05:27:56.4979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9GeVFuf7XPaosawI4kiqGUembLYm4bj0fNoGsFJQGhPzwTzXK8QlHYIOBv/kvoiLt3wyXIRr32vVPoRuy7CWUG5gCx1l5iBvkxK8W6uulXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6761

Hi John and Petr,

> On Wed 2025-06-04 13:56:34, John Ogness wrote:
> > On 2025-06-04, Petr Mladek <pmladek@suse.com> wrote:
> > > On Wed 2025-06-04 04:11:10, Toshiyuki Sato (Fujitsu) wrote:
> > >> > On 2025-06-03, John Ogness <john.ogness@linutronix.de> wrote:
> > >> > > On 2025-06-03, "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>=
 wrote:
> > >> > >>> 4. pr_emerg() has a high logging level, and it effectively ste=
als the console
> > >> > >>> from the "pr/ttyAMA0" task, which I believe is intentional in =
the nbcon
> > >> > design.
> > >> > >>> Down in pl011_console_write_thread(), the "pr/ttyAMA0" task is=
 doing
> > >> > >>> nbcon_enter_unsafe() and nbcon_exit_unsafe() around each chara=
cter
> > >> > >>> that it outputs.  When pr_emerg() steals the console, nbcon_ex=
it_unsafe()
> > >> > >>> returns 0, so the "for" loop exits. pl011_console_write_thread=
() then
> > >> > >>> enters a busy "while" loop waiting to reclaim the console. It'=
s doing this
> > >> > >>> busy "while" loop with interrupts disabled, and because of the=
 panic,
> > >> > >>> it never succeeds.
> > >
> > > I am a bit surprised that it never succeeds. The panic CPU takes over
> > > the ownership but it releases it when the messages are flushed. And
> > > the original owner should be able to reacquire it in this case.
> >
> > The problem is that other_cpu_in_panic() will return true forever, whic=
h
> > will cause _all_ acquires to fail forever. Originally we did allow
> > non-panic to take over again after panic releases ownership. But IIRC w=
e
> > removed that capability because it allowed us to reduce a lot of
> > complexity. And now nbcon_waiter_matches() relies on "Lower priorities
> > are ignored during panic() until reboot."
>=20
> Great catch! I forgot it. And it explains everything.
>=20
> It would be nice to mention this in the commit message or
> in the comment above nbcon_reacquire_nobuf().
>=20
> My updated prosal of the comment is:
>=20
>  * Return:	True when the context reacquired the owner ship. The caller
>  *		might try entering the unsafe state and restore the original
>  *		console device setting. It must not access the output buffer
>  *		anymore.
>  *
>  *		False when another CPU is in panic(). nbcon_try_acquire()
>  *		would never succeed and the infinite loop would	prevent
>  *		stopping this CPU on architectures without proper NMI.
>  *		The caller should bail out immediately without
>  *		touching the console device or the output buffer.
>=20
> Best Regards,
> Petr

Thank you for your comments and suggestions.

After consideration,=20
I believe that there is no problem with forcibly terminating the process wh=
en=20
nbcon_reacquire_nobuf returns false at the pl011 driver level,=20
as in the test patch.

It feels a bit harsh that a thread which started processing before the pani=
c
and then transferred ownership to an atomic operation isn't allowed to perf=
orm
cleanup during panic handling or the grace period before the CPU halts.

I would like to hear your opinion on this.
If nbcon_reacquire_nobuf() could acquire ownership even after the panic,=20
then driver-side modifications might not be necessary.=20
(The responsibility to complete the process without hindering the panic pro=
cess
would still remain.)

Would it be difficult to make an exception to the rule,
  "Lower priorities are ignored during panic() until reboot,"
depending on the situation?

This is just my personal opinion.
I think it would be good to get feedback from other UART driver developers =
as well.

Regards,
Toshiyuki Sato

