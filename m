Received: from addi-data.com (firewall1.addi-data.de [62.154.208.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E94620D4E9
	for <linux-serial@vger.kernel.org>; Sun,  9 Nov 2025 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.154.208.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762671816; cv=fail; b=cDTArWqdhVvsRphsD6rQF12AyjTSfQcxXyc+JN1CmiSBhieOuXj7Kk6SRicC+naKLR07ItlXRJIj2HVZDwrUeq+OmhLX4FZmVRzg86Rx2vdKJOnUrGX3RvvlV4KTK2igSsZLefOY5Qon5IYIQg4EdIF+Q05pIUzARqv9Wrqf4G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762671816; c=relaxed/simple;
	bh=UcMALMWhf3Mie1tzgqJo+ziD/aASnVWrE0H69/iVpQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zrt7GX4jdRm66AKjiBjho9ByMs3RMOeYKdhmAy0gDb7CRh6XRKPbGGEh02ktIAJ+TYVsYUnUjFitQC6BVjehXh1LYSBHD0CG7MxTwIRheeJFxniAJmqSEyuL0G/Gm6Fa34oC/5Trol6AJifaLdTgnuH9SbcumjM2XxlB4MdItoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=addi-data.com; spf=pass smtp.mailfrom=addi-data.com; dkim=pass (2048-bit key) header.d=addi-data.com header.i=@addi-data.com header.b=ob7yg0Yv; arc=fail smtp.client-ip=62.154.208.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=addi-data.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=addi-data.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=addi-data.com header.i=@addi-data.com header.b="ob7yg0Yv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=addi-data.com; s=standard; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UJYoRhUboxZyw0Lnn/M0K8iiGTAPO2oRRmPhxm1ZcR4=; b=ob7yg0YvNO3kLWaLLUHX0buYcd
	aUF5t+8Rl5DvCLgzYGJ6oNmIZ3rJMZcpiYxRVRirppSn2cPJr6jFu68m/d8wZj15JftqUUYfFAQOh
	Q1Umax0Ocxp2hb8fCqcd4ynd0J2xda7mMZpEejaHGrUL7S9xVfhksDi78ncNDDnzGo6cxBIsVDjZI
	7Xrnd+Y6kE573Vo/yfz5PErDoVakxrz6CK8YQwGnVpXqIR6HhI4c0uyNpifXWVDJYVfS9WnPXgh9r
	Xy/RyUPBZoIyYZ23ynVuGs1yjh5C6TCoK77YbCFsQqA0Zp21DYqqEJTvZtEfFUQcTDUcSNes+QigA
	aVn7ItQQ==;
Received: from [172.16.2.41] (port=38628 helo=security01.addi-data.intra)
	by addi-data.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <Magne.Bruno@addi-data.com>)
	id 1vHzSJ-000000003oD-0wtv;
	Sun, 09 Nov 2025 08:03:19 +0100
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022136.outbound.protection.outlook.com [52.101.66.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by security01.addi-data.intra (MTA) with ESMTPS id 4d43fY0gtsz5Hjy2;
	Sun,  9 Nov 2025 08:03:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THkRuPaODFZddhYZz4mMWQsW/E05ZY2iE2LXKZxc/crMrs57FXYlyA0g9pQUHecrfYEBkLrYXvTAukEvbRSX6VlTsA5o0qFLhJPIGT7uWDlFqi3X35fxpPW8oJ1J0nSaE1MzhWza1NwhHC1DmIzhMC34L/eK9D47q7iIHWq31i7VC3UxNaTYTfPIOMflM9C0C+QALamsSYqydbOP7ve3Zf4B79TfdhzWPnLIL2E7fZGR/kck3GeFYml4w8yij5esbOShKKyY1s6hBLRUxU3us2Q1Bxv4rh465TRLRUb1+izmNlaV8hEUXLz32vISK4PZbzVdqsCsX03dFyLYfNAUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/Jn9zSqfQQEojFHj5Dw6WLxsM9Gm3ddhVFwiRizUhI=;
 b=IkbcLK2fGjDgO6Kj7Hw9BRa9QV/NKmNefC3LwRoLWgpAYcxLpA1zJNbgggjoZyBXM1koiCUOLyFdh1WGQV8U3wGyMg0PLQmN2zgJQflZzRsNy0UEUJ1i4Wsl+ZlnGFYXN7KXzD/zx3gRwyM85Go73Pu7k1T237Op+cbMrBBg6zn0Nq87bYJgUI966TFeXmI7Eh7IHUCcZolhZMef0lolSfdOhlLRDXvDvvZUQWfq5Jt3qfRAKLtzK/KBQXNAx10u8qEZ6D4c8LDRd0L+GU3tB5Rdfhy6HL9ZNWkdjNZ90rVqg2Gq8t/kJKAArD6apXFwfbIY21rO0NLUO6dsB6/gvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=addi-data.com; dmarc=pass action=none
 header.from=addi-data.com; dkim=pass header.d=addi-data.com; arc=none
X-msw-original-dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=addidata.onmicrosoft.com; s=selector1-addidata-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/Jn9zSqfQQEojFHj5Dw6WLxsM9Gm3ddhVFwiRizUhI=;
 b=e6GWUzySyFpgv07rneIYtartJxGbVIHQltOfXLckgy4/J/geRPLV0oh9pmiBQvU/uJ/MwO3oL+ZV5NQEMcpluwNB8wyzfoP1lNjo+6q4nZlCp5l/Pep2qnGVnIzA/ig2tueZmcKxJrbwJVAScqnioQZeCxbQOkDZ3PzAZQcHlRU=
Received: from AS2PR08MB9917.eurprd08.prod.outlook.com (2603:10a6:20b:55f::5)
 by AS8PR08MB8609.eurprd08.prod.outlook.com (2603:10a6:20b:565::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Sun, 9 Nov
 2025 07:03:14 +0000
Received: from AS2PR08MB9917.eurprd08.prod.outlook.com
 ([fe80::df0a:631a:1616:8759]) by AS2PR08MB9917.eurprd08.prod.outlook.com
 ([fe80::df0a:631a:1616:8759%6]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 07:03:14 +0000
From: Magne.Bruno <Magne.Bruno@addi-data.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH 001/001] serial: add support of CPCI cards
Thread-Topic: [PATCH 001/001] serial: add support of CPCI cards
Thread-Index: AQHcUPkkysAOv9HL6EWv578Saj8PmrTpg6cAgABiVlA=
Date: Sun, 9 Nov 2025 07:03:14 +0000
Message-ID:
 <AS2PR08MB9917F98E256B2C7A97EA5BFAAAC1A@AS2PR08MB9917.eurprd08.prod.outlook.com>
References: <20251108214617.77631-1-magne.bruno@addi-data.com>
 <2025110945-poison-luxurious-7e49@gregkh>
In-Reply-To: <2025110945-poison-luxurious-7e49@gregkh>
Accept-Language: de-DE, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=addi-data.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR08MB9917:EE_|AS8PR08MB8609:EE_
x-ms-office365-filtering-correlation-id: ac147812-0441-4c15-0f9a-08de1f5e0d58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?+K6EzrX+ZAYo8tgE23XGHiijT8IwzqAAElpxfGXR1q3BTyA8Y+R3RlW0Wr?=
 =?iso-8859-1?Q?ZQXqQx87x6ucM0QMQfZ10+qwRQ3V/wPoBusJT+z5vdyIoHM5rXB1pQovdM?=
 =?iso-8859-1?Q?qP6kIVcqXLesfIc+KYTnZVCb2lp5DrW+bqKwLjiJNusHKaBHmRP6IuKoUf?=
 =?iso-8859-1?Q?oSJAcVTKaw0so2PvCsE4JR49U1ERSbzrhTMhIFVyUuFWj1i+BXBq66T9Ww?=
 =?iso-8859-1?Q?cJ/3nAxn6Ppa6nRogb5Er9sXQwkLuTsJlRghymotKC6LnS5e3S5BncipVk?=
 =?iso-8859-1?Q?yQ7Ofyd5Nf9ODzOvfF8BuZ5jVnj85YdWONdIKlH7rV2hT6TiYe05M0M9Dn?=
 =?iso-8859-1?Q?SH4tHPIO23qcpUVNAAAhb4AA36R1TLB+w9P2xEB0EM3zlqZhTb8lyMtP7b?=
 =?iso-8859-1?Q?Yb7pyQdsKaQumHQsKIGHj9RD0Iianyc++PkJyaLobT9XmzYIAUtJLzyeEs?=
 =?iso-8859-1?Q?vBAPZ85hjB6g3rSmZDoawPf6j9Jqp3qfb43hY2wt0MlE/QjasvEVGGy8R3?=
 =?iso-8859-1?Q?2klHHQeXdvB3xWtEnDBDSujYS9BEYB7twaSgrE3MW0rL6nNkkyE1PSifhR?=
 =?iso-8859-1?Q?sXoiidULOCQqxFDPku9fsAPvIApL335IJSfMLEZzGyjgWHJhKutehjta5P?=
 =?iso-8859-1?Q?HtJc0LBaaF+sYmwBmqqCxfaNiT9VihS+cbJMjlq+2ydePMV6N49OTcpb46?=
 =?iso-8859-1?Q?oS4k9sIFPNARWpOn2fbxmemT0MluMyrGV56KiUzIE7dfKMBTYUGm1Pe/vA?=
 =?iso-8859-1?Q?lb3cLQmmkj5P7rnvcm7rxrOhyoOK/BcJooWPQcq6tY+x92bZ7LRZej6Wdg?=
 =?iso-8859-1?Q?MoqPXF/10YOJZ2yhF7v7gzVu4Sy0Rt4mpUsZFbGoJ48f2ayDPoOmuqksnl?=
 =?iso-8859-1?Q?Tah60luMuB5GHPCqhbQ6Cc4hMQYFlPxe0CZrNR54k/rYWC62EWo6aO4yB/?=
 =?iso-8859-1?Q?GgXP8iXLloUA/juZlHJcM85V64z7lpddmbB5b13YO2mZO08RlgSdeEl/Vb?=
 =?iso-8859-1?Q?8R9qqpg/Vh2AqHBgCQ2IfGYmM/Z5xfgd+NKt7D9qUoIfmw68bmBqdVvgMM?=
 =?iso-8859-1?Q?OWeCYObpsaxK+EeTlLwEaoEqq4dAsxBru1oxek9bhoYLO+RztJen9HHAWe?=
 =?iso-8859-1?Q?znCuZ9xP1kIK+XVwVMOdwvQ9kBkGCFh0DnBUACcYbK2eoNmPlfgdKGFoGV?=
 =?iso-8859-1?Q?ChonnqT4rfQZkWi1ind421DLW8iGKqH5Gmty/ANUP7yMP0Z3dFRsM2megx?=
 =?iso-8859-1?Q?/r7HphELv82CF50q+3zsZRlxlDfybTLVlHrQUeTyzDT8vREGGpiozyIO2u?=
 =?iso-8859-1?Q?6jnJlFUUnY7N1s+nd6r7THVFLefsktv8tC/IF4t4piqKax45zcv/7xNt5Z?=
 =?iso-8859-1?Q?pW1Ld4hZIwXZxf2MC4xh/bG63fDYQTw42PB98InWnmAbsgkgpB//4eDmco?=
 =?iso-8859-1?Q?9PPX9zk610DxRMmcH3tZC+PBEDnzu7nUIZc1Omb46PoeYAq/tuUguLrTJP?=
 =?iso-8859-1?Q?B2FKSAkrc+IZMueEA3kYbSp3E7DT3LpBQiQ3kd3hoj0+54Y+hvqz4xFwJh?=
 =?iso-8859-1?Q?CjhDGZ0E7JoWRELkxZ37am6AvkzD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB9917.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?PWKvo5i4XYkLZpyIwGAWivUE2dCTWyCqS4UZgiLgUC2HUGnL2rONr6p+E9?=
 =?iso-8859-1?Q?0qgIPrTqPveJh0WEEWOsqW5e1a7cEs29rMdCrJEeLKzdihuJSI8eccvKjL?=
 =?iso-8859-1?Q?b3lkeA8bBYOaBoGwmyKYufu4oLDlJ8G52leXMDOim/LOMxxtz1chZHyuvH?=
 =?iso-8859-1?Q?ouTZkl3A9PBHdaxi2g5EyJwKUyeZsrlg9HcFoy4gUhCvOGqqmkaOtGPce9?=
 =?iso-8859-1?Q?Sm41GsdWf3vbY/hLoL6qAjIKX2TlxRfdxlawe8/K3cdXZK0CwJjRnerrTD?=
 =?iso-8859-1?Q?daUwoL0yt4eokxUMCnRu5ON1dLdExr2LmgjBDQ7qcunwgagFqfQdLuDd+L?=
 =?iso-8859-1?Q?Cm1vfprGiGaTE1LuyyAcdzD5IhVaQhKzvgBHdcPXBR/fCkuZqCyqY/pjmH?=
 =?iso-8859-1?Q?j2VPrs6OSWDvUcnqQmB1ujWJFwNvFHZ5/MbuPgiMvwCJdYygCEXJqUn1bz?=
 =?iso-8859-1?Q?HDK/EKRAhV15enTLXT9o8RwzQwEWICzdMmv7JJ+SHLJp8rOcVUw24PYDrf?=
 =?iso-8859-1?Q?FQxAa7Q8TRozJdIjm7ytJfb2NOcE+FkrNyfLjLYhj4rUSQxNb8H4hAyrh2?=
 =?iso-8859-1?Q?oU81nwyB+HMe/HNQIsoTvp9pwACXSMxjmYuEfchl9xUfkDMXeGAZRAFcwf?=
 =?iso-8859-1?Q?ZxYRrsKvJN12hYpQzEUrb9D18SYhf6x9XTS2jGtLDvfwGaxQfuFP/bpndw?=
 =?iso-8859-1?Q?IJhbVEibHs2gVTVfo5vzRgA/3+c5CFIDt3rEJB8Iwy8qDpwGTOORumwl3i?=
 =?iso-8859-1?Q?TldRfdaSaNacPmhbMGtgELoqATgNYz4RguByVFwTE2nBp1ttLv5OpcrWwz?=
 =?iso-8859-1?Q?MwuJvykGUlW5Zx9bO924Vn5ymuDXah79xSENKvWe0JcGuWQiA0coK5Uf/N?=
 =?iso-8859-1?Q?hjslpmBZVEVp59VT5HIPnoAKmaRwhB+nkpV5fXH7bX+BwHBs7K/ZVU89A9?=
 =?iso-8859-1?Q?8MPzfZPIMR1tuSBIq4UrLnDMzDcgPsLND15JX5OgJcLg/MAAGf9HMMgUOk?=
 =?iso-8859-1?Q?FGMMpSEB/XHZFGQjKVjT92/y7qkCxznH+IyBpOpvgu1/k10SbAEwMdPqyB?=
 =?iso-8859-1?Q?JJjj6OKScj4pK831YHlApaOqDtDOzohwKFR+dnc3lqaGgv+ZDH1tvoXi8W?=
 =?iso-8859-1?Q?OfaM7GwkN+8ouFXk9zRsQNoSpOQ3Oh8OLs/0DiUkIzHbkOutptG0YxBnKF?=
 =?iso-8859-1?Q?AEqMZxDdfi3YwGoSqJ9vbY1JN0FxSsvo2HLYwWUb0rzDMrnMoWSOyaac0q?=
 =?iso-8859-1?Q?vjv23WPA53yYsFFf5p+Mk06VUf/0ExiNCMyqQIj0xG6U4lNUjtD4PUOQrA?=
 =?iso-8859-1?Q?GkaGO+E+mpsaCuLZxOnQfnSWNaup4s+XJUIn4sV+PvgTFOIk72J3yfOXXm?=
 =?iso-8859-1?Q?G9ARZx9XPtG9zgdbw2cI1kcd1fuJADf0Dkf0YnjjzhRkljw9PmmX+FIJl4?=
 =?iso-8859-1?Q?cBJ2B+SkAKs22hDE3IyFydkMN+zzyfiJrIPMC/EsMJFkzOBsYYJyCdm+B2?=
 =?iso-8859-1?Q?rzR+sPFLigpwknZdsweEp0Ie9V6+Opp55Z4lgc1g4xcH8kkxqFoCterr7U?=
 =?iso-8859-1?Q?vLJC7SZ8L8TraIKjadd8LV/DBP316xFzWWT8KdbEOcKD3GUbAyhbOTrnnA?=
 =?iso-8859-1?Q?k8UaenlaB50zaaHGRiFHJJO8VdRR1Rym46?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: addi-data.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB9917.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac147812-0441-4c15-0f9a-08de1f5e0d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2025 07:03:14.3903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 08e9ac5d-a1ac-4651-9388-1e0361912f99
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: potOxAiCQj85dC4kYsLEzq2ujbMQE2oG9RvfA1LZ+oKU2389qbtbd67DU8TXnHOC77AhOt3HZX98cZQVQXcKt1KuKiiSAPZWgP3JLlbHQGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8609
x-agari-authentication-results: security01.addi-data.intra;
x-msw-jemd-newsletter: false
X-Sophos-OBS: success
X-SASI-Version: Antispam-Engine: 6.0.1, AntispamData: 2025.11.9.55719
X-SASI-RCODE: 200
X-SASI-SpamProbability: 9%
X-SASI-Hits: ARCAUTH_PASSED 0.000000, BODY_SIZE_3000_3999 0.000000,
 BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
 CTE_QUOTED_PRINTABLE 0.000000, CT_TP_8859_1 0.000000,
 FROM_NAME_ONE_WORD 0.050000, HTML_00_01 0.050000, HTML_00_10 0.050000,
 IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000, MSG_THREAD 0.000000,
 MULTIPLE_RCPTS 0.100000, MULTIPLE_REAL_RCPTS 0.000000,
 NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000,
 OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000,
 SUSP_DH_NEG 0.000000, __ANY_URI 0.000000, __ARCAUTH_DKIM_PASSED 0.000000,
 __ARCAUTH_DMARC_PASSED 0.000000, __ARCAUTH_PASSED 0.000000,
 __ARC_SEAL_MICROSOFT 0.000000, __ARC_SIGNATURE_MICROSOFT 0.000000,
 __BODY_NO_MAILTO 0.000000, __BOUNCE_CHALLENGE_SUBJ 0.000000,
 __BOUNCE_NDR_SUBJ_EXEMPT 0.000000, __BULK_NEGATE 0.000000,
 __CC_NAME 0.000000, __CRYPTO_ADDRESS_OBFU 0.000000, __CT 0.000000,
 __CTE 0.000000, __CTYPE_CHARSET_QUOTED 0.000000, __CT_TEXT_PLAIN 0.000000,
 __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
 __FORWARDED_MSG 0.000000, __FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000,
 __HAS_FROM 0.000000, __HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000,
 __HAS_X_FF_ASR 0.000000, __HAS_X_FF_ASR_CAT 0.000000,
 __HAS_X_FF_ASR_SFV 0.000000, __HIGHBIT_ASCII_MIX 0.000000,
 __IN_REP_TO 0.000000, __LINES_OF_YELLING 0.000000, __MAIL_CHAIN 0.000000,
 __MIME_BOUND_CHARSET 0.000000, __MIME_TEXT_ONLY 0.000000,
 __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
 __MSGID_32_64_CAPS 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
 __OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
 __PHISH_SPEAR_SUBJ_TEAM 0.000000, __REFERENCES 0.000000,
 __SANE_MSGID 0.000000, __SCAN_D_NEG 0.000000, __SCAN_D_NEG2 0.000000,
 __SCAN_D_NEG_HEUR 0.000000, __SCAN_D_NEG_HEUR2 0.000000,
 __SUBJ_ALPHA_END 0.000000, __SUBJ_ALPHA_NEGATE 0.000000,
 __SUBJ_REPLY 0.000000, __TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
 __TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
 __URI_MAILTO 0.000000, __URI_NO_WWW 0.000000, __URI_NS 0.000000,
 __X_FF_ASR_SCL_NSP 0.000000, __X_FF_ASR_SFV_NSPM 0.000000

Dear Greg,

If, we do not add those Ids to the serial driver, the driver will not manag=
e automatically our 4 CPCI cards, like it does for PCI and PCIe cards.
The result is that when booting the kernel, the port devices /dev/ttySx wil=
l not be created and the board is not usable.
Without this patch, when using "dmesg | grep /dev/ttyS" we cannot see the s=
erial ports associated with those cards.
We have more and more users using Linux for industrial applications and thi=
s is a limitation that
those cards cannot be used out of the box from a  a standard kernel, Debian=
 or RedHat.
I hope that my explanations will convince you.
Best Regards
Bruno Magne

-----Message d'origine-----
De=A0: Greg KH <gregkh@linuxfoundation.org>=20
Envoy=E9=A0: dimanche 9 novembre 2025 01:50
=C0=A0: Magne.Bruno <Magne.Bruno@addi-data.com>
Cc=A0: jirislaby@kernel.org; linux-serial@vger.kernel.org
Objet=A0: Re: [PATCH 001/001] serial: add support of CPCI cards

On Sat, Nov 08, 2025 at 10:46:17PM +0100, Magne Bruno wrote:
> Addi-Data GmbH is manufacturing multi-serial ports cards supporting Compa=
ctPCI (known as CPCI).
> Those cards are identified with different DeviceIds. Those cards=20
> integrating standard UARTs work the same way as PCI/PCIe models already s=
upported in the serial driver.
>=20
> Signed-off-by: Magne Bruno <magne.bruno@addi-data.com>
> ---
>=20
> diff --git a/drivers/tty/serial/8250/8250_pci.c=20
> b/drivers/tty/serial/8250/8250_pci.c
> index 152f914c599d..924ea92d17d7 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -5996,6 +5996,38 @@ static const struct pci_device_id serial_pci_tbl[]=
 =3D {
>  		0,
>  		pbn_ADDIDATA_PCIe_8_3906250 },
> =20
> +	{	PCI_VENDOR_ID_ADDIDATA,
> +		PCI_DEVICE_ID_ADDIDATA_CPCI7500,
> +		PCI_ANY_ID,
> +		PCI_ANY_ID,
> +		0,
> +		0,
> +		pbn_b0_4_115200 },
> +
> +	{	PCI_VENDOR_ID_ADDIDATA,
> +		PCI_DEVICE_ID_ADDIDATA_CPCI7500_NG,
> +		PCI_ANY_ID,
> +		PCI_ANY_ID,
> +		0,
> +		0,
> +		pbn_b0_4_115200 },
> +
> +	{	PCI_VENDOR_ID_ADDIDATA,
> +		PCI_DEVICE_ID_ADDIDATA_CPCI7420_NG,
> +		PCI_ANY_ID,
> +		PCI_ANY_ID,
> +		0,
> +		0,
> +		pbn_b0_2_115200 },
> +
> +	{	PCI_VENDOR_ID_ADDIDATA,
> +		PCI_DEVICE_ID_ADDIDATA_CPCI7300_NG,
> +		PCI_ANY_ID,
> +		PCI_ANY_ID,
> +		0,
> +		0,
> +		pbn_b0_1_115200 },
> +
>  	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
>  		PCI_VENDOR_ID_IBM, 0x0299,
>  		0, 0, pbn_b0_bt_2_115200 },
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h index=20
> 92ffc4373f6d..221a83d4e1ed 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2333,6 +2333,7 @@
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7500        0x7000
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7420        0x7001
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7300        0x7002
> +#define PCI_DEVICE_ID_ADDIDATA_CPCI7500        0x7003
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7500_2      0x7009
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7420_2      0x700A
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7300_2      0x700B
> @@ -2344,6 +2345,9 @@
>  #define PCI_DEVICE_ID_ADDIDATA_APCIe7420       0x7011
>  #define PCI_DEVICE_ID_ADDIDATA_APCIe7500       0x7012
>  #define PCI_DEVICE_ID_ADDIDATA_APCIe7800       0x7013
> +#define PCI_DEVICE_ID_ADDIDATA_CPCI7500_NG     0x7024
> +#define PCI_DEVICE_ID_ADDIDATA_CPCI7420_NG     0x7025
> +#define PCI_DEVICE_ID_ADDIDATA_CPCI7300_NG     0x7026
> =20
>  #define PCI_VENDOR_ID_PDC		0x15e9

Please look at the top of this file, there's no real need to add these new =
ids to it, right?

thanks,

greg k-h






ADDI-DATA GmbH - Airport Boulevard B210 - 77836 Rheinm=FCnster (Germany) Am=
tsgericht Mannheim HRB210433 Gesch=E4ftsf=FChrer Ren=E9 Ohlmann
UST-ID-Nr.: DE 143754253 WEEE-Reg.-Nr. DE 65862200

