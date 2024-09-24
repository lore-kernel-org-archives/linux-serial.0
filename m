Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620431A7AEC;
	Tue, 24 Sep 2024 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187183; cv=fail; b=nODxrQwL8Sz252m49/zUXzIV+Cgo8Dwz4YH2asWCC0vPhiVNUNExTNcQARg6uV7n8r+px42pLeUED+9xv8EKIpPc2Fc2joyOE3xgP4QQq8OL4WJ1q/azdqG0wUHIHOUe1ZSEJpLSlB+mFizlL2jC1IBN0kZhH0zBFoR9YGikh7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187183; c=relaxed/simple;
	bh=oDDXauypNdkQQ8fmGLKES1gHJ6ooCu5NAYWxl/YM5ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h115iLky/vIK2WDKdT/QMo4zgvdZPlBHGcUcCVi6K/mFe1nkmu0i3dKA05ZLX6VI7Is45QcKsUoSDWQZxjgZjVmrpNYW3nbhyrNs9L1GAuT1kG8zH/JLEucO8B9QulSOWGdIUT3bR2Fs4eKCQsknE/Pru1+bbKMeqxnKEOBjFp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Vd9Iv95G; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Vd9Iv95G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0CHb0KA0zYmiDL0h7ItjEzvq6ZDCglds04+xrldR4PF2U5lBJs3j+aeS8AkLnJo/nG8aVfkBulP1ke+OVoSCjq/1q6bV3d3f8hKAQFcSRK5ceNghIeddEBOss3tr3FF13oKjg4eDVipIuuoaUBm+tIqLy9GeCbXbKujocxec274dR+YGMO4nHmgNkv7OSAmtdC3ofAkrKMpESfzkPueLDfTVq9VXcsmpn+7UsrCh6MU3HQ0K9uhTyy1ebTAH/nR68txviWIL1hNtaedtXFputL0Sx6DlJkOpa5pI04Vwg9NpRbxIjCdSVqvWsaCfc6hKfSqbTKwOG/xF7ueFOMpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+0p77TSPj04O9uwhC6YZekEGQUgX/00MAKKxt60OtQ=;
 b=BPZHkyHDJTbXDCOOjGzn7pF1DOmfULUJcUymPZYOADWz5ZZ/Es72GIS22kCurt/Tmov0rjx1RQ+//aFHMYN2ke/GexcjMkdsxqXPY0nH1sx3WDRpI8rdW1ZQ5DHcdyYQgWw6appHZZZEcOiY16j1gz+ZD4cU5hUxXR2ixMX0MCm/46waNBCRXuq3hl5DIRoJnNl6dh4Zm7/ZSQ7ptuRhdMF2h0owi7jjtPI44ktR2m/HDckshiQ4HRC+Hd++TUHkm0b7qf9VCS8r34lvDtPtVvfT4uv0T5kB74rnfjHCe0v09vDwjWl2n0kfgkVbWWHGjEvLYvilq9dj/OkudhmUZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+0p77TSPj04O9uwhC6YZekEGQUgX/00MAKKxt60OtQ=;
 b=Vd9Iv95G4ACx7tIH0qPiTthOsS7ozflfR3iPMvd2uGH4Km/2orQlZMmwGhEsgu2geSwcCZ0P8wtY6FCVrPPNMKm1ENx2Ps7EwbeluCMAIUDTM+bj29xNusO+iFUqM+NX8wW7OM1l4z0kHStnUNcOqYABnwvMB5ba5mgnjAesKc0Gpg8FTwPX5wrxC1mRkMlOlNUBG2/UgqIE+vEKK3IGNBMX+ae+tdp3W27stfGgdUQOW4Pm3wXAfJg8Y5vAhAqZhFHoMQl7luDNh/yZpjp5XmmYlcx1u3SOGcwjaNJAkoMEmeNKCTJQdPC/bawSUHgGDXFCRw5DT+VISlY9g+57zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DB9PR04MB9791.eurprd04.prod.outlook.com (2603:10a6:10:4ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 14:12:53 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%7]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 14:12:53 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chester Lin <chester62515@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 1/2] dt-bindings: linflexuart: add clock definitions
Date: Tue, 24 Sep 2024 17:12:46 +0300
Message-ID: <20240924141247.132455-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240924141247.132455-1-ciprianmarian.costea@oss.nxp.com>
References: <20240924141247.132455-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::38) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DB9PR04MB9791:EE_
X-MS-Office365-Filtering-Correlation-Id: ea174864-4e54-4a4a-dceb-08dcdca2faed
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjQyMW5sU2xad0ZnVkY2dTB3ME05RXJLU1lFcUE4eW1HV2RDZ3VHZWpKRFc0?=
 =?utf-8?B?M3ZOQXYrRWFaQ2tlRkFBWWFSaUJJL2Nxb3NYVVpZWmt4NHFRc0h3NEVuUnp6?=
 =?utf-8?B?Z3FBZWZzUmNTbHMxazJZSmg5UjJCK1JwVmlpcDhqdHpvdzRRYkIrYXo0eGx2?=
 =?utf-8?B?V3VSckl0TnhzYkFBU3BVZFdyM1pEZkg5QWdCWTIydERyc2YrRHN3WUZ5bVha?=
 =?utf-8?B?MWFNdHRHdWREZ3BNaGFKblpmUzB4TkdsdmtaUDhtRFVJMGc5aUVMK3ZiU0cy?=
 =?utf-8?B?OWIycXFaYjcxYkZIRkpwUUJtajJZQmltVVZIVFRYMzRzRE5pbTR4MHAzS09K?=
 =?utf-8?B?QVZWZUpRYkphUjlqUUIyektoclFxbzRwYThuWldWNjlXV1R2UWhLZWZCZllC?=
 =?utf-8?B?azA4dW9MaUJzOStlc3EvcGxNQmltMTJqRmxhVFJIeEZURTg0cEZyMVh3RFNz?=
 =?utf-8?B?SENUL3BjTG9TeTQ5bjZMVXlpNGlrNlRkalRZZEY2b1RWNmtROGR0elEweVNE?=
 =?utf-8?B?amhTelNEb01xY3FaVjBscG5QZ2hSK21EeG9hcHd2RjBpZXVmT1Z4NXF2WTVw?=
 =?utf-8?B?T0ZxVy9SR3h0aHh4cS9RaWF2VEVTQmhsVXFGN0w0OUJHdXJ1TXM2WUV3bFhy?=
 =?utf-8?B?YU5aNjNydWlqcFM5TitBNXFWUW02WVRZYWlMM1oxMkt6NWtzSnB6ZFFWWHhG?=
 =?utf-8?B?RzFzMlY2WEtRU213OHB5Z05oa0RjNVlRRnBjdkhkVlphaHVWek1nRjc5b0tk?=
 =?utf-8?B?c0ZxakVWTHl6bmIyaFowTG81ZVlwODQzNjZXRWZtdW1tZjcrZGdUYjRGY0Zj?=
 =?utf-8?B?UkxVN05kUFRWenUzQmZZTUNYcmN1aEtmZjRMalJQdHcwRlVtYk91UmRwQ2xF?=
 =?utf-8?B?VzJTUXRaYXo2TUxySFJLVFNac0ZZclNjdkFxMHFMYnpQYUpZSUZYdXQrUnZj?=
 =?utf-8?B?eGdqQ0RrRWhYS2w0QS8yUW5pd3dQUnI2M28yd3lrUndna2kxLzk4Nnh2dVcx?=
 =?utf-8?B?VmRKcytRU2ZRc01YcGUzZnRocTFJSWtrdlp6cmRjL3MwQ3p5OHo0V2R1L2xW?=
 =?utf-8?B?VzluVlhZYU5HRkR3bjBUQkZXdkpjOVNBWlVVMDJYRmkvUThJeEZtNUNGVWth?=
 =?utf-8?B?UHJja0ovZm5VRmw2amNYU3NwOFkzbit5UHB5VkpkUTVvdGtVL0dvTDgrLyt1?=
 =?utf-8?B?WHRXaWw2S1EzQ2hnVGowWU9GampOKzRkeERTMDVUeTdkZUM0SFl6eDRlbXR1?=
 =?utf-8?B?czNWU1M4UVA2a0ovS0ltZHp1SFlRYjJHUkxmWlVTenZTa3F0YU8wdFdqMUZk?=
 =?utf-8?B?SEpwdGxnMmJnSWo0OS95ZDYyYnA1OURzQXlGZXRIN0Z3SllyeWcvb0lmMFFu?=
 =?utf-8?B?eHRwc1ozY0ROTEJYdkVZYnhteGdlc3NEeklTMzY0UDkrRTNYdGVIK1Y5cDdV?=
 =?utf-8?B?S0NNdmZpZUhwbzNta01vQkhSclNhRklRSWhnbzduSW9xUzdrMmhLS0U0N0Z1?=
 =?utf-8?B?ZW9tWFZJZjlGN0t5OHg4MXZwb3hXN2tjUUQ4TEVlWHZuUkJXT1ZDS2QxRGlL?=
 =?utf-8?B?ZXpHZlZhUncrMlozMG9qVHVPNXd3cmh3ZUdLdmh5cmJjMk5lcHR2REl6S1RO?=
 =?utf-8?B?L3BvaHdaM0lpVkJBUnhtN1c0N2pERExTN2NKSGF1WGtNcVlVam11M0c5amt2?=
 =?utf-8?B?RGR2c1NCbUd4WDV1T01oOHVacDN6M3g2d0Q1cnMxcDJlOVRCRlhRZjgvbklK?=
 =?utf-8?B?U25oTEVRRm5EN1VHdDAvQTkrZnRkUkFGTTJGOEZlYTdCN09FTzF1dlJWNkhX?=
 =?utf-8?B?L2hvb0ZEWi9GOE5HdmkyZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXpiNkpscEtGdDhycGlTNkwrOEZkNUJmWjJYdEhCOUdSZFU0NVI3TVJZUlc2?=
 =?utf-8?B?ODNud1FoMDEwYm40MnJRcS9tdmNmMUVNTW5kSFpMVnhFK3l5MHMyMzlLQUY5?=
 =?utf-8?B?RGpoelR3aDVWS2lrdE53ZC9BNXFxWXcwNzYvZWQzYjdnZkwwZHorR0J1NGJC?=
 =?utf-8?B?WU4rZ21qcHVYRFFUWnhsMVNPR3BrT1Z6WmtrWDloN2pGcmxJRUFoRGhWT2hJ?=
 =?utf-8?B?NFFYNlpVbWEyb3hkRU9IOFdMb2ZmTXYrMUJqODc0dTJOTUkxVUd2VTFwZTRs?=
 =?utf-8?B?YXR2UE1PcjlCRDZySXhKd1NERmJxa0t2OXFOY0xaTSs2bDRuU29PUDhGUHJ1?=
 =?utf-8?B?TnRyRC9VUm5ZdmM0MThyZmhtNHNhV3FMWDBWa0pwei9NMHdVOEtwYkFlYmFn?=
 =?utf-8?B?YUdQRkd6aUVZRXg3NmkzSWlDQ20yTExYTGI2YytVRUhqOStGcDlkZ1g3a2pR?=
 =?utf-8?B?cE1hdTRWcE1ydnM5ckJ5MmlNTnV6cDZWaGdOY0hLS29Qd0dCWW8xUmVQYjU0?=
 =?utf-8?B?ZTdIaDhDOCtJbUZ5YktJd001Y0wxSmJRSjcxNnliTktiQlQvTFBSSjBnM0Ey?=
 =?utf-8?B?bXlBdTJta2NHRUVLZkZxSUhabW9uRXl2SzVDYzJETUR0Q3ZBSnRHVDR6QlZ2?=
 =?utf-8?B?Z0FKa0h0NVR5N2xpbmJuR2ZxMXFwc01mQ0dNeXF5YWZQM0VwdU9Wb29NNXUv?=
 =?utf-8?B?UEFGOStWcHlsUkplQ3FkVzJyL0R5cjl3di8vSUtXMW1YdW9WKy9YV3hwVEsr?=
 =?utf-8?B?SG1LdmZTTmFKNGk5ZjU5L0ZrR2V0V3ZQWFhKWmhPelB4eStXMVpXakxvMlA4?=
 =?utf-8?B?VlA1OVg0M3d5aWZxWXM1MjEzenV1SHhrbVBKOHpMM1NzbnFRaWgxL3pxU2hM?=
 =?utf-8?B?T3ppMjRacmc4MGUzT0hBOWVlSzJqdXJYMnJqbHJ2SnVyMHR2RXZlT3h6am1Y?=
 =?utf-8?B?TXhaTjFmdzJaREsxS3ZUZGdLVXBwS2RWK216dHhsT1QzU0p0RDYxSDdTUUhI?=
 =?utf-8?B?SURnTWpETENCMXh1aGlTNGZRV0RCUG1CdGwwemY3M2NHQXM1SHRybnFIYmdI?=
 =?utf-8?B?Yi93TjY2a2ZXR1dudmtucHhJb0lUakgzeVV6cm9OdGh5MGMrNEVENkZlc3hv?=
 =?utf-8?B?TkZCMHByUWlyTHI3djJvQWozYWdLQ2I5VEF4VmZRRHp5Z3ZCREtxa096QS9H?=
 =?utf-8?B?eTZIdndmMUpIejJGaU5tVGVVNTcwbTM3STZCSG5DTW1zM0NnVTJ0YW1od1Ux?=
 =?utf-8?B?cXowVTRJS1ZuRXU5L09XMzFWVWpZWkpJYmE3aTA3Q0gvOHlnenZtdFB6MnFz?=
 =?utf-8?B?VUk1Y2o5RmgvYW50T1cyWFpiS2dISlFQQ2M1d1lIZm5BMlBoL0FBazI2ZEtF?=
 =?utf-8?B?WkZncTlqR3R5dCtGalp6K2dKcjFEQkd3MGhrQytreHdCTURrejBVWkVrdnVM?=
 =?utf-8?B?VzBJbFNWOXRqcTBPcjBJanRVWkU0ZUVtR2xvUDN2K1lLQnRTTHBqWENqdXRT?=
 =?utf-8?B?dmxwY0c3VS8xa2xIN0g2bTJsUGZoL1hKMkEvSmgydFVncDNGemtVTDVmZ3VX?=
 =?utf-8?B?YlVza2cvcTZGVTV4T3o5UFd0VWY1Qk1McE04UGpnTVdrek9Pei9kRXVZak5x?=
 =?utf-8?B?eDJWMlJ5SXVQWWxvcVlkUk5FWFN6L2NNTjdjT1NYbWI3M0oyV3U5ZFdYTFdF?=
 =?utf-8?B?KzRhSnlwU1F0UGhtaW1qWWRTRVR4RERhKzZ0WTUvTXhBZHdsZXEydHlpZ2w1?=
 =?utf-8?B?TFUxNGRmZ3RXdjhaM3Z4dFJUVElHM3dQK2VnVDhEUWd2Mi9ma0pibW82c2V1?=
 =?utf-8?B?alNZRWlFNEtGSkpKclNPbnVmY1V2UFBHNVBGRlFZNFEwczY5aXcyOTZXRUdV?=
 =?utf-8?B?T3BoUWVIeEIzdXhoNFNJYUt4WkFOcjhuMVBIUCs4eG9reTFGcTN4R1hPQXhR?=
 =?utf-8?B?N3VnVXVpVU9Ma1BZNGFrM2VVU1g1WG0zcml5NkZuMmtYQWlvY0ppbndWMmhS?=
 =?utf-8?B?UEV0QjdsazNGTGovTHpXWmlVV0hISTd4RDVHL3ZtNjIyTHU5Mm91MC96YUFl?=
 =?utf-8?B?ZzZDT3dDUVNQVUowUitENlA2NEhGSWpXSlFnTWMzcVhTTHZBQVBVMnlWUWNl?=
 =?utf-8?B?QVVOLzB2by9MalYxQ2tEZmY3R1dNNGhLZFJSWW9JMVJMRjlDQXVwTlJDUUQ5?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea174864-4e54-4a4a-dceb-08dcdca2faed
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 14:12:53.3615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ngKNpw85229J4IrOVv0YudsGpYGozWBDSUTjxv3RLcLHY9dMafV0t5W2NQy5+4B0epOR3xdAVBJef30MHcpcnGqwyqpOZXjCX63gp4PoxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9791

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add clock definitions for NXP LINFlexD UART bindings
and update the binding examples with S32G2 node.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 .../bindings/serial/fsl,s32-linflexuart.yaml  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
index 4171f524a928..45fcab9e186d 100644
--- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
@@ -34,6 +34,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: lin
+
 required:
   - compatible
   - reg
@@ -48,3 +56,16 @@ examples:
         reg = <0x40053000 0x1000>;
         interrupts = <0 59 4>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    serial@401c8000 {
+        compatible = "nxp,s32g2-linflexuart",
+                     "fsl,s32v234-linflexuart";
+        reg = <0x401c8000 0x3000>;
+        interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clks 14>, <&clks 13>;
+        clock-names = "lin", "ipg";
+    };
-- 
2.45.2

