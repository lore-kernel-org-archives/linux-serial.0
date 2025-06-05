Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6682566;
	Thu,  5 Jun 2025 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749104563; cv=fail; b=bOZXVw7FWkf0/k/YrM9NiTkW3rFR/Od1fmLsxOpvp9kGfzTpitww+NrWlxx+EwbunDbR3brD3SV6QMCdz5cpR58Bmnihlhf77+FOpeAxGETcnRg6DlkxQdSIkMznIfwUW9BV5EHZRfpJpKaOLxyjqwkkW8vRpS15GmUksU+2TUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749104563; c=relaxed/simple;
	bh=HtiquZ78IvL/gzgledz+tIW9669mSu2I0yTW6vb5fn4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ODUpNW4rBLxwM+z0yvkDLqmjOQhFX0S/6eLcidBb5TmLGA1+2MP6PsdgxN5E9FF8Sf2HTHU27O+kJibikSfxEw8PhIIIUR8ICJF2N3Ev+KFEJWmSSDWJGZLseL1Qqk2f1LzdfyHFStzutn98KJFh2yGfao20Ryx2kQd/YQFlNEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FtSLXByI; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FtSLXByI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1749104561; x=1780640561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HtiquZ78IvL/gzgledz+tIW9669mSu2I0yTW6vb5fn4=;
  b=FtSLXByIfjaBE5Hdw3bUiqrBc8RN1jBkEWaiGrwNv1TlvZrNkeJo4esl
   B6ZoD+dQnzm4LXxVe86gscdwmDqmJdVnZT8fU7TEwrnPdISTbifuIWbV9
   60naSWj7R9JapoGBoZX9yzaTjqvr8Cxg0ki6BqYke/cUfCcyQBwrJakTL
   1Zausob8A9Ynxj2/qzQd4WK4abH2b1wMmooj/4p1ByDxjE71ROvYQzaiJ
   gFxGclGqLSPFx++b1XXcd6cyE+qxz+qkRFyxX8BVdz1jwUegDXFx79L9C
   xsHrqOSLmN/x3aXZlrprb66e1Yl2+whBvOq3ayZNMEpS6Zo1Xi5hkNWvs
   Q==;
X-CSE-ConnectionGUID: 7lX69ihpSLS+xYTctCToXw==
X-CSE-MsgGUID: 7H41dKylTOKZP48ClbgQmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="157755964"
X-IronPort-AV: E=Sophos;i="6.16,211,1744038000"; 
   d="scan'208";a="157755964"
Received: from mail-japanwestazon11011060.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.60])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 15:22:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiWF3wEchJQYiEZdPd1/9vlVXndWpf0WpG2l4zrHCdMRZbuSGD5/97pMfoHSC1PFshFwPzPYDw0G1Uf0YhJ1IBEYmNdJ3tVXpapVKFI8oCgMxO04ZpiBOtaLEW4tPc4b55zZbDSdgP2tY5GUreLF+ykQQ3P5EpNdb3yHJhU2IFCkXQGv1QsRmEJaNv5uygFPIWvALg06kUQw7/P9adbqdhWk91fzymdmkysdW1jeCazqOVcq8AzG6dAp9LLFMvopMJcLQwZTA8dsjqwe4nSwGGm3QmxLYPiFkGlh2gGK3ux1TtWy7dTIzw4YbHlc6FgEEXQzgRcRCf4aT1EtwBOs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDpQwsvMeQhy1g5Qe37w/GUbJI+9UWBLoxRQQxyIY+o=;
 b=bcvuD+bxJVwrFrTzfF313tSzOUi77209d9uH/IJP6V5T/8Lc2++3l8GseX2HreEDsaiXchqQtJDdG9ZcrK9l0bhxnQYZ3E3InxT+BW4ZKxnCIJnUHOrICuB5SJSJoOhpPINC3PiQ0JaZfGx9VIz2PaqegX3trd/N6nJZFAGmUfQr132VXS5bDBmlg/MX2V6dpJgpkEAE6PF2lgwWqSD/B6ipVwleHv+KsJWE/4EPiDOxFB9xSx2g31TnJmP+zN4oWT/dIQJK+Aw9tU27edQkGHntOZ/26QWp2U1Vp3EHbqjUw7jrmzFTufUXJAB8D4DH9/iwUi+yqzglAamdhlEeOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com (2603:1096:405:1f8::9)
 by TYWPR01MB10971.jpnprd01.prod.outlook.com (2603:1096:400:390::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 06:22:32 +0000
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc]) by TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc%7]) with mapi id 15.20.8813.018; Thu, 5 Jun 2025
 06:22:32 +0000
From: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
To: 'Michael Kelley' <mhklinux@outlook.com>
CC: 'John Ogness' <john.ogness@linutronix.de>, "pmladek@suse.com"
	<pmladek@suse.com>, 'Ryo Takakura' <ryotkkr98@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Toshiyuki Sato (Fujitsu)"
	<fj6611ie@fujitsu.com>
Subject: RE: Problem with nbcon console and amba-pl011 serial port
Thread-Topic: Problem with nbcon console and amba-pl011 serial port
Thread-Index:
 AdvULbS8DdGjT9TLS9OOSVhbv2AtDgAN1+gwAALFDgAAAfWTAAAeB8NgADP4FvAABDFXIA==
Date: Thu, 5 Jun 2025 06:22:32 +0000
Message-ID:
 <TY4PR01MB1377757DD5E7F27A41F0B4723D76FA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
References:
 <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de> <84plfl5bf1.fsf@jogness.linutronix.de>
 <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <SN6PR02MB41575419E1223B8A8B0A1F1FD46FA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41575419E1223B8A8B0A1F1FD46FA@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=73bc6bbe-f07a-4241-8f3d-c0bd835e27e2;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-06-05T04:22:32Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13777:EE_|TYWPR01MB10971:EE_
x-ms-office365-filtering-correlation-id: 560be7a4-5eb7-4f74-a469-08dda3f95af4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?RHFGUGExZHJ0SS9LYWNydUE5bllJT2ZJU2pkQ1BrUVZwSlA2bVpnWGd0?=
 =?iso-2022-jp?B?L0Z4dm1VS3p0YWhPSkNOU0tZLzJuVlFpZWRGWm1aSTFCRytUaFlJNzMr?=
 =?iso-2022-jp?B?a1dyMnBrMTNTOXE4RVM3cE9LMWxSY1RmOTc1c042TVlwbkx5eGJQcEM1?=
 =?iso-2022-jp?B?STArWU4xSFJNOEpKbVgrK2pPNER0aXQwMi80TE1BS1dNdWtheWZkc2U0?=
 =?iso-2022-jp?B?K1pEQldDZXpBY294cUNGUmhsM0dlVlZ6RU9YY3ZHTEQ4cVZMc3RQRTlB?=
 =?iso-2022-jp?B?elUyM3pjUU13Zmo4VnhLbUxiL2ptNnJvUW5DNW5BKzJoUmR6RnRmZjJR?=
 =?iso-2022-jp?B?Z0lLdFJJUnZ4ME84c3hvR2FpRk9GL05hTjNoY0ZDOU5TZ2FmWjA4bjhB?=
 =?iso-2022-jp?B?cDQ0QnhENDlMLzJqazBZeTgvQ09mL2hVUHJWT2NBS1BmZ1VEZW8zNDdh?=
 =?iso-2022-jp?B?OFJIZDhSdDY0RGRveHpnMG4vYzhxTGt6SnorVDRVeElZMHlCMGphM21r?=
 =?iso-2022-jp?B?QmYvNzY4akZCU0lIYUJ0MUp2YzBGQUpva1JVSHkzNVl3Yk1JWnR5YU5W?=
 =?iso-2022-jp?B?RkU5ZXU0TkRvRGlnUkRIenJMT3RZY0R3eFpuNFpka0E3MXZNNEdCR1pJ?=
 =?iso-2022-jp?B?U3RjQ0duYWZJdlEvN3cyNjl0dXBEN0tCS2ZldDBkUGl3MEorbXhKWW1s?=
 =?iso-2022-jp?B?UmtJTGpnaWdnem9HV29DZUJxRFlaTkNEY2RObXRySWNYbzhxWGRGYy9o?=
 =?iso-2022-jp?B?Z253T0p6bGFnTEFZQkxVUzF2Z1k3UnVWaW9HaHNuMkJIWUFQaTdYZ3Vl?=
 =?iso-2022-jp?B?Q0FNRjFJZ1pLalJVZ2kyZU9wVEpYUGhYVEFMOXlsZ2VJa0toV2FPMEVv?=
 =?iso-2022-jp?B?Ym94WVdwaUFEeXFrUXQyRHBlemxCOEFSbHRNbWlPRnpiVkUvRWdxb3J3?=
 =?iso-2022-jp?B?L25VVkRuZzBEa3hIclJ1cDFUWTlOT0dBUlpzWGhYemR5MUp4U0R1bFVo?=
 =?iso-2022-jp?B?czJrcGNyM25YZUw0dzcrb2NNSE0yRUJNSHNyNjc3bnUvL0oxN2o3VTlz?=
 =?iso-2022-jp?B?VmI4aVVzNENtWnpXUjJUZUVTeG9OUHorSkloWlE1R2xzTFAyWnB1bU55?=
 =?iso-2022-jp?B?SEpndmhIaVhmc2xHbGR3bkpqRWtrNzI4L2hqZEVPNmFWOVFudXBENXh6?=
 =?iso-2022-jp?B?T3RhcUk1QkV3WmtlYUVhQXhVZytROXMxcUVPMWZsQXlKWEVUNDEycjJP?=
 =?iso-2022-jp?B?MzVKeG5ITUI4cHFJZXgxejdwTUZHdTJSdXA5ZXJlVmtaR0hSTlQrcFEv?=
 =?iso-2022-jp?B?cGIzaENGNlZZTU1FOWM3bTBJeFB4aElnSHBxa1FnM2ozeWs3YXJpblFu?=
 =?iso-2022-jp?B?QVB6dmZhRjNBUlpsVkFibytkMldRa2U5bUw3bEtEQ2xPckhBS3AycXRJ?=
 =?iso-2022-jp?B?K1VDMTU5ZElFcEFqYTRoMUIwSHhoZjVHMmh1VkRTVHorNHYzWmp3RmpM?=
 =?iso-2022-jp?B?VFp1aU96U3VXR3B3M1ZvbWswSEExWktkZnB2M0ZDaHlXcjduSlQ2Yll5?=
 =?iso-2022-jp?B?Q0hMOXV3UHh1RVBEOVU5THhYQXlicHVidWdCZ2pESUdaUll3ODFoY29Q?=
 =?iso-2022-jp?B?Qnpsd0V2M3FoWVJ2eEJMbmVVVmR0bE1GS21kOU5sUkl0ZlRtMDdZV3Vq?=
 =?iso-2022-jp?B?M2tlWlJ6Ulc5TXJmRlhxV3dBZEt4bHU2Lzlkc3BmeHQ3aG1oMXd0UXc2?=
 =?iso-2022-jp?B?N1JOSHh3Z1JuZXJMdk1iVVZVVXYrdnFoZml2VmFEU2Uxc0V1WmlhaUVh?=
 =?iso-2022-jp?B?UnplTGhKdHN3TnpkcmxhS0sxbERhM0t0T1U4dUFoU2UrVlhSaUxtNGVW?=
 =?iso-2022-jp?B?RW5JdWFqaWFjNGF4VmExTUdhN2ZaVnJ2M1hSUitEa3NLMGlpMVdXaFlI?=
 =?iso-2022-jp?B?RjduYU1YSzdQSVM5SmtxTmYrRG0veG5QZHd4N21SV3VIUHlCOXhrNEQ1?=
 =?iso-2022-jp?B?RDN1NkF3azhvNUs5TlpIdGcreVJRVExaN0Q4ejl5RlkySStpdlhGQVRO?=
 =?iso-2022-jp?B?TUg3UGdrWGlibmJQN2FoT2wrM3gvTUlVZnlOckFOeTBaY05DaE9hMTZY?=
 =?iso-2022-jp?B?b2lBbk5uK2w0VGNPRW1hLzBDSjh6U2ErWXZTLzVDeHpHK0pNbWN1eUtW?=
 =?iso-2022-jp?B?bzh4bStiVXhURXNFcU5nZXdHYTlJUVlu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?dE5waEdTMmVkUG84R1IwSFRhcU5xQWM1UGdQQjdkcFJtUjRtMjd0NzBC?=
 =?iso-2022-jp?B?Skt1YUNlS0tOYlJpeEswbFJtVUZ4ejRnNEJzRy80NVdxR291MnVWSm5U?=
 =?iso-2022-jp?B?S3ZZbE5xZWFDRDljV3pkaVJoZGZUVWdwMXphRTUrdHgxMGR2L0xTamtB?=
 =?iso-2022-jp?B?RWEzeXRPeERpUHN5TjhmMS9QaEhidy9lY1ZCbkpEd0RwR2ZHdUN3QjVa?=
 =?iso-2022-jp?B?L3RQc0oyOXdsc0RCb1dCaGdFNDBiRldDeHM2Vy9TdzBDOFFGQ0ZMN2Nn?=
 =?iso-2022-jp?B?RnRSTVUyalJlR3FGQ2V1VWRBN0MwUzZzM3FzTnJJLzVVMTdCM2tGMkF2?=
 =?iso-2022-jp?B?VHNaV01rZnd4a0NLQ1FuVk5LVVV3cjE4RWo1VlBBUlV6RUxwamZCbGM4?=
 =?iso-2022-jp?B?TDlwMG0ySCtZOUhxWGw5NG9jZnFZT0o1NkZ2dzdadkZ2TG9MT21vVWk5?=
 =?iso-2022-jp?B?QzdVb2tzVjJHVGthaldGb2ZwcktkSktRZTBQNzgyMll4VWk2WXMxdGtP?=
 =?iso-2022-jp?B?SFRzRlNSQTRETUdiNjIvZ2NqMExTcTczVTlmUTNwTUw3cGpjMFdHRGhR?=
 =?iso-2022-jp?B?bUVKZGYrMGFEMGFzTnVJL3F4Wll4SnFjTHlwOUZsZ1JKMUZNTWhEQ0N2?=
 =?iso-2022-jp?B?ZUo3YSsxRTFGUWIvWUZ0UlRXL3VNWU1iTTF0YU8zRnFER05Rb0NNS2JJ?=
 =?iso-2022-jp?B?NnQvc0NGQnJoZEF0R2MrYStTWnVQeWx5NEVvZFU3NEdRcjZuTTVxWVpH?=
 =?iso-2022-jp?B?bkVPTUNadUtTNDhFdzRLR0NYa3NYUlNEVXBWVExRbWlDeVJmelAvWmVs?=
 =?iso-2022-jp?B?eG1veWU2WVRnYmltNUtSZzRnRHBHT0xJWnN4WlhPdXkvdy9QV2RMNVB1?=
 =?iso-2022-jp?B?enBkTzRWVldTNDdHSkZNUUhXdkJoU0psQTYva21KVi9WMU9vZkxxREQx?=
 =?iso-2022-jp?B?eHF2L1dYYTYwNWRoYW95czF5T1VMQUJ3ZmgzQlk0T3V2Mkp4QmdvcU1w?=
 =?iso-2022-jp?B?a1p6dTNiODM0N05YSHVIRFNwaG9vLzdZbkNSNjZKRlpVU2FzNTVpalll?=
 =?iso-2022-jp?B?cTR3RHFEZ1AvN04yMDB5SEJQRVJxYXQxdzY5Nk1NUUEyeWM4QlBMQVM1?=
 =?iso-2022-jp?B?MitYWEs4NkF0dVlFNXQ5S3VxVnI5dng3eVdqR3VqYmU2SC80NitPMHRO?=
 =?iso-2022-jp?B?NTN3TUxVM0NVTE1WaFhrZmpLR1hxaVgwYzV6bDZ6YXhzUWZTU1NXbGg3?=
 =?iso-2022-jp?B?aDNkL3hXeTI1Q0ljMytTYUpvRVBYblF4TndHS1loblo5cExBZHVBaXNy?=
 =?iso-2022-jp?B?THcvRkw4ZlExc2F6QUV4aytSUWZTYW5qaVFaaWdDdG9mYzUwMUErZ2Jw?=
 =?iso-2022-jp?B?MUF6Yy9TcU5SbWZ4WTRsTHFpVnAxR0FmUGlta2J6Q3IzN2F4SHJhSUJs?=
 =?iso-2022-jp?B?NmxvbDZUK1grQTZuQW42cWVvY2I4VkxLSnU1NFdLSU00K3VxUlU1UVlM?=
 =?iso-2022-jp?B?dkUyRFhreG5BRlNjZnd2dVI1VHNPRFZ5Qzk5UGREN2N0OGpiRENwSjVH?=
 =?iso-2022-jp?B?bXhFTmVYTDI1WHpIdklrRHllV2x1RkNSZGpHajR2ckUva3ZMSUVVTWty?=
 =?iso-2022-jp?B?MklXbENOVDViTVRxdUNPOFlXaEloZFhLbDQrd2FaQXpjSXQxbUQyMDZU?=
 =?iso-2022-jp?B?UXUvbEl0b1dmeG1FbzVPVktoK2ZNcmY1WjRUUHFCRi8rTlNFbjVvS2Q2?=
 =?iso-2022-jp?B?cGZhS01uUHJ6dE4zUS9hbVRqMEN4bTBZV2J6ZytPZXpNL2wvajNGZGly?=
 =?iso-2022-jp?B?MGlqaVhtYjJ3cVNFTytlWDBoSEJ4LzhJT2tTLytrVDhlVy9mcDJDTklp?=
 =?iso-2022-jp?B?R2ZqNTNET01QckJKbU9xT2dtcXhkUWxOeW9tQUdJYlArZHprcjZBWnVR?=
 =?iso-2022-jp?B?N2UzdE1ubTJRZVdOWTVNTXEyNzc4RG5BdnNCZXhDeDVMR25YTFBocm9O?=
 =?iso-2022-jp?B?anJxajZIQnJnaDZMR3UrMXFWd1F6c3UrOHh3VGtxelFvRGFTMVBpRzdP?=
 =?iso-2022-jp?B?UnBjRTFraFhuZU5uVVVvZGQ1bTZCT3JGS1hLd3hBM0hKSFQybjBNdTEr?=
 =?iso-2022-jp?B?VkRPU3NMZmRzWEZ3QW9iWExNSWJvempMTFRuUWdBOTdLWUdSOVBWTFBy?=
 =?iso-2022-jp?B?UTlNSkY2UzNPQ1JyZzRXUXp4QjkvTmFUQ1plVXAzNThwSFdvTjhxL2Fw?=
 =?iso-2022-jp?B?ZlhjdjRZRHZ1ejhQb2tsbDlBWEx4U3hkMWdOYkxnbUtIL3FrQ2VteFNX?=
 =?iso-2022-jp?B?NzhRd0FjQjRuQml5WitMb2tFa1hyZjRwcXc9PQ==?=
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
	6/8o4zQnaHAhvBkhQG+Uu+g2KnMS/FxbpeaHyuWiR47M6JmuKB48YJBohStRzv/bYLNAsBs00vhukaOUTOZfchT0X45T+7uqujuc6zDWPphYFKIwm4SxIs90jDvYe7tCR2ueL/It2t14BpG65YAZQNwmQWqqWU2KhEBtchLMeyz7r9vTWtQ59i/J5wzkhenoSW8C9llDtVcfXGX1cELJeE6Htayq/MONoeigwPdYbmP2J21pExSuP/GvRhUoFrgOCJeXig0kTxr0XSdjg0mGrtvi7o0d12SMOMwMFahXhDmUyIgyZEG2nto0XzGsirW1C026o2pBKitA2f1fwGEN/UykkVjHivNeY1YGgCd240Di9mcPnrLA5hZ1DmLa0ZGgPQV5CQ2y7Co0N3LhyMEj4Nm/1gwCftaB5Ppwmv47mr9+m42/8e5vokcb5oKmru8r6y0qE0KZPOalJaPq43+36xGWXk+uEVrku3/XC9yj1bXgOyzH+jM2I+oPRKWQjh2y6zGa8tJRz/hSyTXPSby0b2NfnLqdG9ZLrB287mDRpGluOLz+Ez7+n/hdjqIo5aTvIrbkKuN2myIeT2DV9K7SuMaewGa1WI56TY6kpzR4lonyi85NenpewO9nqfKTmbeg
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560be7a4-5eb7-4f74-a469-08dda3f95af4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 06:22:32.4399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+CFWThe6dVfqKZjVlXyCtu/PKEEOgzWkn8KH1gCBwUP36tYNE3pJMMw2tnwCZiTnGWYy5EfUL1xaqd7aZ7nt+NDqtR/Ke9lD9/bCEgFtLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10971

Hi Michael,

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Thursday, June 5, 2025 11:49 AM
> > Hi Michael, John,
> >
>=20
> [snip]
>=20
> >
> > This is a proposed fix to force termination by returning false from
> > nbcon_reacquire_nobuf when a panic occurs within pl011_console_write_th=
read.
> >  (I believe this is similar to what John suggested in his previous
> > reply.)
> >
> > While I couldn't reproduce the issue using sysrq-trigger in my
> > environment  (It seemed that the panic was being executed before the
> > thread processing), I did observe nbcon_reacquire_nobuf failing to
> > complete when injecting an NMI (SError) during pl011_console_write_thre=
ad.
> > Applying this fix seems to have resolved the "SMP: failed to stop
> > secondary CPUs" issue.
> >
> > This patch is for test.
> > Modifications to imx and other drivers, as well as adding
> > __must_check, will likely be required.
> >
> > Michael, could you please test this fix in your environment?
>=20
> I've tested the fix in my primary environment (ARM64 VM in the Azure clou=
d), and I've seen no failures to stop a CPU. I kept my
> custom logging in place, so I could confirm that the problem path is stil=
l happening, and the fix recovers from the problem path.
> So the good results are not due to just a timing change. The "pr/ttyAMA0"=
 task is still looping forever trying to get ownership
> of the console, but it is doing so at a higher level in nbcon_kthread_fun=
c() and in calling nbcon_emit_one(), and interrupts are
> enabled for part of the loop.
>=20
> Full disclosure: I have a secondary environment, also an ARM64 VM in the =
Azure cloud, but running on an older version of
> Hyper-V. In this environment I see the same custom logging results, and t=
he "pr/ttyAMA0" task is indeed looping with
> interrupts enabled. But for some reason, the CPU doesn't stop in response=
 to IPI_CPU_STOP. I don't see any evidence that this
> failure to stop is due to the Linux pl011 driver or nbcon. This older ver=
sion of Hyper-V has a known problem in pl011 UART
> emulation, and I have a theory on how that problem may be causing the fai=
lure to stop. It will take me some time to investigate
> further, but based on what I know now, that investigation should not hold=
 up this fix.
>=20
> Michael

Thank you for testing the patch.
I'm concerned about the thread looping...

Regards,
Toshiyuki Sato

