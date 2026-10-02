Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FF3325494;
	Fri,  2 Oct 2026 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949893; cv=fail; b=VNP7YRTfCb2CVnude3NYpMBkEyLb01MfipO/8HR7h7QztDHsRtYPuvS8pRW2jxzVMLIsOsCAUVaYI+68cxAkIueQ1Wnkk895F+U4G9vBWc7N/2gUeNApi0v7r0eezSniCG71fil0n51vjD7ER8W+V3TCZDOnsjeQyS7Wj133t7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949893; c=relaxed/simple;
	bh=YL3Qlw5MXVPMIeqcwswgLt8K1213kObR0uY+9Oc5zhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T21t+lAq+GR2LWYougOvkhApq8psNcmYAMV+zWI+F88nfvEILacWOj4P/UT+qGwcbarndlPvYxjqJh2VqNj+fKFmfuBe4GKaXnJdqPqlJ+a/KpjaY/FBTCtW9e/2uEdsVEGahphjcTy99rumqyhEB7RWmFBl1FzmakUHBm+0IRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABQFj2Gf; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABQFj2Gf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790949891; x=1822485891;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YL3Qlw5MXVPMIeqcwswgLt8K1213kObR0uY+9Oc5zhk=;
  b=ABQFj2GfSMWuhKtvz7NgDNVaHhtotnVybD7zDDajHeM9Gm3AToxWgNeC
   yUQY+2X98Ac4dBQEZbWx1zpEC/vhxrN51ELjt0Wz5dUM2arCmhgLAbv3a
   KoTDkrZ1hC+95nuT8ZOrxJo2K6alBOLh1dYiuf9oE32Yl5oOSGm2MaPa7
   aGn8n6i9K13JlP+rNeDwYTdJ1dNdHjQAc2Sf/fjSbghWHU4JvH9XljVU3
   o2v4S5YdSvYouEfHPVNm6AId0GmFmlT1VmFcSLlPy9r8csQl2y8/IfKjB
   ti1tu5bJaFP26fT67DROoWs21dManDumelyHSv/4CSMWJOGFp4yymNz0v
   Q==;
X-CSE-ConnectionGUID: eDSnVrWkSg2cc8f/GgxiSw==
X-CSE-MsgGUID: FlP4GbxPQC6Pf61BHwiteA==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="101878328"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="101878328"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 07:04:49 -0700
X-CSE-ConnectionGUID: Zg3j2XeESRCnUmcZFIbsLA==
X-CSE-MsgGUID: M3wftEfoQBGuKg5GqVtYxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="274908057"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 07:04:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 07:04:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 07:04:48 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.18)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 07:04:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUevDDPttreT+rID4n7DeZ0/GBicr2+QRf4DKlLJnoQBGGnRTy5naYfaZ31QZvsiqrqNXZAXdnDV/Bhacp2ZRUMGwVJrEk+Ip/+7vC8GBh+G5dO2F0Z31i+WvG7ZPOPbj2Hqn9lAARYEuwWCOo351pQpXSlDkpmizop++XpOfqP0gCv6hYaSs/8QAeoLbqSImD6Vbg0ZfNhwFmsl+inUFIR+gYR451iLzk0ZBegYGYCdHRpKh7riXX36PhHcZ3nPE6jTCoGLa+WVt+dufvsWT3Z2rJVe9HKxNXVT1mOqWfbIDQW2q8w+WWM6P+yvWr8Zhz9SFFL/Gf/bGmaCECMZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YL3Qlw5MXVPMIeqcwswgLt8K1213kObR0uY+9Oc5zhk=;
 b=l7180ejR/o3ereJ2OhPIAheOObFvz2TfoxFoGWPWQoHOVqM04F6PJxq+kXbh7wJ+m41mF3gul6Gg/+yPyOSz/nABI737+/g4EVL7kE7yX1558ksm/lbOk42XALOgo1BmoRnbuvzdcXxWkRSp0fz8oNvJDn43TudJlm6ZVW/bnAw8b2YldUo6MiYIFWsAkuJTtlxOQQ41cS6jsVl+CnhVkXHcaohIR8Xq5MrBCtG14p8PnjbMmxZX9q0RhrNgNrVRLncWK2Czww80SEoBOnP+8wUAeHM8XlEf8pb0vX1k06SrW5gRFuSAjqgxdjf8S4g8b2Fa1oWLe4gsFIXb34qeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6309.namprd11.prod.outlook.com (2603:10b6:8:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 14:04:40 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 14:04:39 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>, Wim Van Sebroeck
	<wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Ian Abbott
	<abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rudolf Marek
	<r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>, Chris Snook
	<chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, =?utf-8?B?TWFyZWsgQmVow7pu?=
	<kabel@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Noever <andreas.noever@gmail.com>, Mika Westerberg
	<westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>, Chas Williams
	<3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez
	<da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin
	<atomlin@atomlin.com>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-atm-general@lists.sourceforge.net"
	<linux-atm-general@lists.sourceforge.net>, "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] hwmon: Replace __MODULE_STRING() with
 __stringify()
Thread-Topic: [PATCH v2 1/3] hwmon: Replace __MODULE_STRING() with
 __stringify()
Thread-Index: AQHdUkidro68mWt0BUODIpv+im9/wbbqRJZQ
Date: Fri, 2 Oct 2026 14:04:39 +0000
Message-ID: <IA3PR11MB89860D2A835ED010DB8639F0E5892@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
In-Reply-To: <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6309:EE_
x-ms-office365-filtering-correlation-id: e00275a8-f054-42a9-ee2a-08df208e19be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|921020|3023799007|4143699003|11063799006|18002099003|22082099003|38070700021|15866825006|41080700001;
x-microsoft-antispam-message-info: syuDao1unHsjPYBwx4DMVse0fRxc+cvJXMn65tcFHjxNXQHofWwV4VsKGSwB8JOW4uNQIlNADKZp3cZ7QAudtgQ+v+tc5mMV5xYrFPiypWkQVMxdsPJqg+Knnk4ZxHmoD4qugCr5G0KSb5qI4j862Riw62V2VeYXeeNXhOjldlcOF3P1Gw2wnHFY/pVSLGIN5/YrrlZzycaLASBI20LkAoGG3PcHOR1w+ImPou/lXqXfRdrWDantFMTD/47O5AZBd6BZk/Db52KTIeP/17l29dTz/8RcoBPp486B13aiY1ylzx8+U5ttjRs21GEba/SstatFpIQPwwNH8pJXsoxdXuybxPXL6U3YjxMvA2P8iLBOgihOMc+OIdY2a/53Q7ClS4ATNzONigbPX0C7q7bVr5YyrY+mJz/Wyee8ZHtntc0aLGVWT/4Ipwl8mzNPrzhnUlmxFBH3lxgYkEDD6moHfcDXuALm+5zo08RQ4nox3wgFVuJMzKq6sGX9RS7Eid1Tm58Dgk+kgHDTVw+Ee646OYUiP98dbcSQO84Ml/wnIbK4G9X2jSsbIWmir+DselWIVQc49gEDO1oSvSMZHBzq9IxEcOmo7KCQDBsCQR7peZXlrInPfG/PAwUJ04PMAKniENq4Oel/w8wd8wMByoyvMrDCJP8AyM5erBtTmH2dq8e/xBi1TUWir+UEUZbFgxrFDDQ6ug6xPdUxi+zKP1YpXz/Wk26OceVF1rpotKdNTW1BqStUH+WiS9XyL1RZGWMXFgHZZfUJ7DOJVpTWThQ8e60QeMQdhV1xPAnFpJCkD/ZCZJnHKIyw2u6DagJsUWvT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(921020)(3023799007)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021)(15866825006)(41080700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1RLVmhObWQxanRhbmo3TmNSL2RXSUw0VkluaEZuRUdXNkxGUkdIa05aZUlW?=
 =?utf-8?B?LzFkbmRqSVdvVStUR1M3dUp0L1E2OXBkbFR1ZWYrd1Y0OCtlK3J5R1BvV1Ba?=
 =?utf-8?B?RmxsVCtLTDlpVDFTbklNdkJxQjNTZmloUEpBdjlid3drdkJYU29CeGpvSCtj?=
 =?utf-8?B?Z09pSEJ2UG5iOStucU1zY2FhUzJ5c05zanhvc2x2cnJ3dk5FckFoYVR0NXk1?=
 =?utf-8?B?V2pvRnZObnBzSCtVek84NWNGaHF0a1liekNuaEFycHRhUHJuNGdMdjM5RnNC?=
 =?utf-8?B?ZlBxRWQ5M3BsN0p3Rktpb3NqWWpUVFJOdldvYytUSlhlcGRBdUdxY05pd0hE?=
 =?utf-8?B?YUQvU2JwZTZ4RFhCSU9JemNDOG5Kdk1OWi9uRU05d3VTb0lWZEhGeTg1S1J0?=
 =?utf-8?B?aEtySlMvMFVaQjYrdUpVQXNSSXV1WVkwNEUxSkVocmxxNWpTRW1uMU1zSjJN?=
 =?utf-8?B?dkpFbFozS0UraHRNM0pKQkFlNC9nVUtkT21XMDhYVVYyczF4Nm5XTnBQOW5I?=
 =?utf-8?B?MURSSDZ2RFZ0REM0NFdacmNOTHhSTWxvT3VvYXl3R3daR2FBNi9RcitGcmg1?=
 =?utf-8?B?bjhMVm1vamNoVVZKeTk0VkJBcFBQeUMvdlBEWjd3elo2bmswRVAzS2VTa3JV?=
 =?utf-8?B?aUgrc3dmVWtvS0Q1WDA0U2pRSnpTL0JhSnUzMG5sNnlQeTVoU09rRGlaMXd5?=
 =?utf-8?B?WjRUQno0NkdKNENvMTlVVHdMM2h4TGg4QnhtUDV0b0FLTXJLYTJ2citTZlFD?=
 =?utf-8?B?YjJQNUtJYllyS0JHMTFpU3BoaHpSZ1lZSFNaeEVjMWl0a3pLMlMrVXJnWC8x?=
 =?utf-8?B?WGZBUk91OGhCZ2k0V1QyNWF1bWEwcEtTSlNwZDlpN0UzOHhiVngwRVlYQXIv?=
 =?utf-8?B?d0YzWlJKeFk1Q2VIaGlwZm1kMExPamVtbHJOR3Y0VWtnMUxNbzkxZkNnYnBy?=
 =?utf-8?B?KzRVbkphajFVUDZnRGNHK1lXOTFOc3JjZnF4WHpJaDBqN0JoN2YzdkptOGhO?=
 =?utf-8?B?dkNXc2FSdHNKMVBSZ21aRlRTR1BtSzZ5ZW12K0I5T2pYUWlvbDlvWThEbDZq?=
 =?utf-8?B?N2RpaWxPNmJONmorRnJpUjR0RXd1cFRiSWxWTDl6UzNTSVByMGtTUGQ0dTZE?=
 =?utf-8?B?aUhGd3ROSzYyQ1RxeXBhQk1YWjQ5eVh6VUpNNzg4RmNKY1l0MjltOG9oclhB?=
 =?utf-8?B?STJyaWNGMnl0WTlLVjdYUEI0ZU1MYWQxT0Fac0ZVdC9jcm1IMS9EZG9UY2FW?=
 =?utf-8?B?Y3lzQUh5WGZNVThDRDVoeVBSdmhPeUFMOWFZOWtrejk1bFFrTm9tMHRTVzJG?=
 =?utf-8?B?cklUY3daTFltY29QMFpDUGdIb0tMeUlubUxaTkJoZkRGaXlOTmU0eWM0OHZW?=
 =?utf-8?B?STA4aFJEdVlTbnAySHVoclUvMlp5TUxQSmNsek0xdnhIRG9tZWlGb1hURlF1?=
 =?utf-8?B?amZBV3VxakhXMWJZbG8xS0hRUEFxUkR1VjFaWjhhVkJKSFF5MjRQbVloQmZv?=
 =?utf-8?B?MWcwL3BkdmQ2QzdNOENFZ1ZBVmJqWmdMeUtjQ3A5V1BjU3ZMNUZDZ1psRTRj?=
 =?utf-8?B?NUZuMUI3VTRVMU1aNlNib3lRZU5KWXlRU014SFo2T0RWVkJZbDg4MjJ6Zlll?=
 =?utf-8?B?Rm1qcUlpWXNBRVBCMWdnOU5CRFRBVDlreWpnYXpJTS9HeStqVkdIaEZYN0o0?=
 =?utf-8?B?RDFYV0dBTnJMa3cwdk5IWGpRS0VZWFZlL1Z0UklzeXFTaFpiMFBtMUhhdDlW?=
 =?utf-8?B?TzQyNWZIUW5LekF3cWd0WmE4TEV3MkpCM29hZkV3ZEh5L1Zhemtzb2MxcFRt?=
 =?utf-8?B?allMWnlKUURMOGFMaC9XOEhEb1BzejdZeVFoNkh6aXhodnNsalpzanQ5QWlE?=
 =?utf-8?B?Zlg4VXV4SzUwUjBKTmtZWnJpL2UzSFAxRER3T3VmRXl4NWtSK3JxYlB5ODIy?=
 =?utf-8?B?TWtJbTFuVXZ3R01vTjM1Zm8xQ2trN0k3NnlJMldQVTQ1Ymlxbk9RcTYyWjBK?=
 =?utf-8?B?MFJDUmljOGJYRjZOck8zclc3RWp4S1VQa2RZcmhqUFFtMGxrbzFQa2wyeHUz?=
 =?utf-8?B?ZTVxYnRqWE9XZHU5ZExkOURJdUF3ZzIxZnBGbXJUWkhEZWFkY3ppZ0ZPTG9E?=
 =?utf-8?B?SGN1NzhRMFNoQ3UvcUNPRFQrNGpoSG9OMnhsWGR6S05seDN0SnRwclJnR0hy?=
 =?utf-8?B?Ykd2TkFzTUNqcnh6NFkwb0Z2SGpMZng2RVM1cWF3NUhtUHJURVNyYkNlVVVJ?=
 =?utf-8?B?bTVmb0lCL1M5V053M3R2SURlZDB2TVBYeHhnSEdoNFlVMXA3RFNZZWIzQ3cz?=
 =?utf-8?B?dVUrZDZLTzk3Q1BQM2pBWElKUnBFdVhJU1hLT0crMzArdjVzN3phdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3Du/azlX5/UPErrRMZBbArrpf888KN2ubJN9X+GQ2Wjkekc3vRGC1IuZ3V5anQJySp45/dDNb0lf29xUcmoHISc9gGoFKlbMtYOt3wQ9j4Yu6Wh5ywUMoGTm6ImIH71tnkRIk8PNZSzEPFBfml5XQEe019aEo9j1QpvzutHvXyzQnQqnu1YrK+7Qtpg8l5sgu1eARq9ZmcGE+AAlWCmg76B7D02wml/aA0oJhIkB4AmFB/nKk/JQ2twXDQmM/oVetkLbM0W16i9iJeSYb+zxFE79ezEIzOD1l+y440wJ/EdDR0REYyjzjXGW3VVlKAjiTCpIKFoI+Ry/oHNOd5b41g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00275a8-f054-42a9-ee2a-08df208e19be
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 14:04:39.9018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRLux9BG8UdpEoKUOF4/1dqaMNizvhHS6uvZyp3HMG7EdU++Y8muZsDalohPZY7m+zPsbYmgNml24wrWfytpe4K1/lOu1AzFthg7H3jbfdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6309
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ciBQYXZsdSA8cGV0
ci5wYXZsdUBzdXNlLmNvbT4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDIsIDIwMjYgMTA6MzEg
QU0NCj4gVG86IFdpbSBWYW4gU2Vicm9lY2sgPHdpbUBsaW51eC13YXRjaGRvZy5vcmc+OyBHdWVu
dGVyIFJvZWNrDQo+IDxsaW51eEByb2Vjay11cy5uZXQ+OyBJYW4gQWJib3R0IDxhYmJvdHRpQG1l
di5jby51az47IEggSGFydGxleQ0KPiBTd2VldGVuIDxoc3dlZXRlbkB2aXNpb25lbmdyYXZlcnMu
Y29tPjsgTWFhcnRlbiBMYW5raG9yc3QNCj4gPG1hYXJ0ZW4ubGFua2hvcnN0QGxpbnV4LmludGVs
LmNvbT47IE1heGltZSBSaXBhcmQNCj4gPG1yaXBhcmRAa2VybmVsLm9yZz47IFRob21hcyBaaW1t
ZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPjsgRGF2aWQNCj4gQWlybGllIDxhaXJsaWVkQGdt
YWlsLmNvbT47IFNpbW9uYSBWZXR0ZXIgPHNpbW9uYUBmZndsbC5jaD47IFJ1ZG9sZg0KPiBNYXJl
ayA8ci5tYXJla0Bhc3NlbWJsZXIuY3o+OyBBbmRpIFNoeXRpIDxhbmRpLnNoeXRpQGtlcm5lbC5v
cmc+Ow0KPiBDaHJpcyBTbm9vayA8Y2hyaXMuc25vb2tAZ21haWwuY29tPjsgQW5kcmV3IEx1bm4N
Cj4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldD47IEVyaWMNCj4gRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtp
Y2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbw0KPiBBYmVuaSA8cGFiZW5pQHJlZGhhdC5j
b20+OyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBL
aXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsgTWFy
ZWsgQmVow7puIDxrYWJlbEBrZXJuZWwub3JnPjsNCj4gQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhh
bmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPjsgQW5kcmVhcyBOb2V2ZXINCj4gPGFuZHJlYXMubm9l
dmVyQGdtYWlsLmNvbT47IE1pa2EgV2VzdGVyYmVyZyA8d2VzdGVyaUBrZXJuZWwub3JnPjsNCj4g
WWVoZXprZWwgQmVybmF0IDxZZWhlemtlbFNoQkBnbWFpbC5jb20+OyBHcmVnIEtyb2FoLUhhcnRt
YW4NCj4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgSmlyaSBTbGFieSA8amlyaXNsYWJ5
QGtlcm5lbC5vcmc+Ow0KPiBEdW5jYW4gU2FuZHMgPGR1bmNhbi5zYW5kc0BmcmVlLmZyPjsgQ2hh
cyBXaWxsaWFtcyA8M2NoYXMzQGdtYWlsLmNvbT47DQo+IEx1aXMgQ2hhbWJlcmxhaW4gPG1jZ3Jv
ZkBrZXJuZWwub3JnPjsgUGV0ciBQYXZsdQ0KPiA8cGV0ci5wYXZsdUBzdXNlLmNvbT47IERhbmll
bCBHb21leiA8ZGEuZ29tZXpAa2VybmVsLm9yZz47IFNhbWkNCj4gVG9sdmFuZW4gPHNhbWl0b2x2
YW5lbkBnb29nbGUuY29tPjsgQWFyb24gVG9tbGluIDxhdG9tbGluQGF0b21saW4uY29tPg0KPiBD
YzogV29sZnJhbSBTYW5nIDx3c2ErcmVuZXNhc0BzYW5nLWVuZ2luZWVyaW5nLmNvbT47IGxpbnV4
LQ0KPiB3YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmc7IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IGxpbnV4LQ0KPiBod21vbkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWkyY0B2Z2VyLmtl
cm5lbC5vcmc7DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGludGVsLXdpcmVkLWxhbkBsaXN0
cy5vc3Vvc2wub3JnOyBsaW51eC0NCj4gcnRjQHZnZXIua2VybmVsLm9yZzsgbGludXgtdXNiQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWF0
bS1nZW5lcmFsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldDsNCj4gbGludXgtbW9kdWxlc0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENI
IHYyIDEvM10gaHdtb246IFJlcGxhY2UgX19NT0RVTEVfU1RSSU5HKCkgd2l0aA0KPiBfX3N0cmlu
Z2lmeSgpDQo+IA0KPiBfX01PRFVMRV9TVFJJTkcoKSBoYXMgYmVlbiBhbiBhbGlhcyBmb3IgX19z
dHJpbmdpZnkoKSBzaW5jZSAiW1BBVENIXQ0KPiBNT0RVTEVfUEFSTSBzdXBwb3J0IGZvciBvbGRl
ciBtb2R1bGVzIiBbMV0gaW4gMjAwMi0xMi4gVGhhdCBjaGFuZ2UNCj4gYWxzbyBtb3ZlZCBpdCB0
byB0aGUgZ3JhdmV5YXJkIHNlY3Rpb24gYXQgdGhlIGVuZCBvZiBsaW51eC9tb2R1bGUuaA0KPiAN
Cj4gUmVwbGFjZSB0aGUgcmVtYWluaW5nIHVzZXMgb2YgX19NT0RVTEVfU1RSSU5HKCkgd2l0aCBf
X3N0cmluZ2lmeSgpIGluDQo+IHByZXBhcmF0aW9uIGZvciBpdHMgcmVtb3ZhbC4NCj4gDQo+IExp
bms6IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvdGdseC9oaXN0b3J5L2MvMTM2ODM5YTFiNCBbMV0N
Cj4gU2lnbmVkLW9mZi1ieTogUGV0ciBQYXZsdSA8cGV0ci5wYXZsdUBzdXNlLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL2h3bW9uL2ZzY2htZC5jICAgICAgICAgfCAzICsrLQ0KPiAgZHJpdmVycy9o
d21vbi9uY3Q3OTA0LmMgICAgICAgIHwgNSArKystLQ0KPiAgZHJpdmVycy9od21vbi9zY2g1Nnh4
LWNvbW1vbi5jIHwgMyArKy0NCj4gIGRyaXZlcnMvaHdtb24vdzgzNzkzLmMgICAgICAgICB8IDUg
KysrLS0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL2ZzY2htZC5jIGIvZHJpdmVycy9o
d21vbi9mc2NobWQuYyBpbmRleA0KPiAwMTlmYzMyYmYzMTguLmRmOTQxOGE4NmM4MyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9od21vbi9mc2NobWQuYw0KPiArKysgYi9kcml2ZXJzL2h3bW9uL2Zz
Y2htZC5jDQo+IEBAIC0zNSw2ICszNSw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvbWlzY2Rldmlj
ZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9r
cmVmLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvc3RyaW5naWZ5Lmg+DQo+IA0KPiAgLyogQWRkcmVz
c2VzIHRvIHNjYW4gKi8NCj4gIHN0YXRpYyBjb25zdCB1bnNpZ25lZCBzaG9ydCBub3JtYWxfaTJj
W10gPSB7IDB4NzMsIEkyQ19DTElFTlRfRU5EIH07DQo+IEBAIC00Myw3ICs0NCw3IEBAIHN0YXRp
YyBjb25zdCB1bnNpZ25lZCBzaG9ydCBub3JtYWxfaTJjW10gPSB7IDB4NzMsDQo+IEkyQ19DTElF
TlRfRU5EIH07ICBzdGF0aWMgYm9vbCBub3dheW91dCA9IFdBVENIRE9HX05PV0FZT1VUOw0KPiBt
b2R1bGVfcGFyYW0obm93YXlvdXQsIGJvb2wsIDApOyAgTU9EVUxFX1BBUk1fREVTQyhub3dheW91
dCwgIldhdGNoZG9nDQo+IGNhbm5vdCBiZSBzdG9wcGVkIG9uY2Ugc3RhcnRlZCAoZGVmYXVsdD0i
DQo+IC0JX19NT0RVTEVfU1RSSU5HKFdBVENIRE9HX05PV0FZT1VUKSAiKSIpOw0KPiArCV9fc3Ry
aW5naWZ5KFdBVENIRE9HX05PV0FZT1VUKSAiKSIpOw0KPiANCj4gIGVudW0gY2hpcHMgeyBmc2Nw
b3MsIGZzY2hlciwgZnNjc2N5LCBmc2NocmMsIGZzY2htZCwgZnNjaGRzLCBmc2NzeWwNCj4gfTsN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL25jdDc5MDQuYyBiL2RyaXZlcnMvaHdt
b24vbmN0NzkwNC5jIGluZGV4DQo+IDk3NmI4YTAwOGU0NC4uMDRlMWE4ZTZkYjM3IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2h3bW9uL25jdDc5MDQuYw0KPiArKysgYi9kcml2ZXJzL2h3bW9uL25j
dDc5MDQuYw0KPiBAQCAtMjMsNiArMjMsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2kyYy5oPg0K
PiAgI2luY2x1ZGUgPGxpbnV4L2h3bW9uLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvd2F0Y2hkb2cu
aD4NCj4gKyNpbmNsdWRlIDxsaW51eC9zdHJpbmdpZnkuaD4NCj4gDQo+ICAjZGVmaW5lIFZFTkRP
Ul9JRF9SRUcJCTB4N0EJLyogQW55IGJhbmsgKi8NCj4gICNkZWZpbmUgTlVWT1RPTl9JRAkJMHg1
MA0KPiBAQCAtMTEzLDEyICsxMTQsMTIgQEANCj4gIHN0YXRpYyBpbnQgdGltZW91dDsNCj4gIG1v
ZHVsZV9wYXJhbSh0aW1lb3V0LCBpbnQsIDApOw0KPiAgTU9EVUxFX1BBUk1fREVTQyh0aW1lb3V0
LCAiV2F0Y2hkb2cgdGltZW91dCBpbiBtaW51dGVzLiAxIDw9IHRpbWVvdXQNCj4gPD0gMjU1LCBk
ZWZhdWx0PSINCj4gLQkJCV9fTU9EVUxFX1NUUklORyhXQVRDSERPR19USU1FT1VUKSAiLiIpOw0K
PiArCQkJX19zdHJpbmdpZnkoV0FUQ0hET0dfVElNRU9VVCkgIi4iKTsNCj4gDQo+ICBzdGF0aWMg
Ym9vbCBub3dheW91dCA9IFdBVENIRE9HX05PV0FZT1VUOyAgbW9kdWxlX3BhcmFtKG5vd2F5b3V0
LA0KPiBib29sLCAwKTsgIE1PRFVMRV9QQVJNX0RFU0Mobm93YXlvdXQsICJXYXRjaGRvZyBjYW5u
b3QgYmUgc3RvcHBlZCBvbmNlDQo+IHN0YXJ0ZWQgKGRlZmF1bHQ9Ig0KPiAtCQkJX19NT0RVTEVf
U1RSSU5HKFdBVENIRE9HX05PV0FZT1VUKSAiKSIpOw0KPiArCQkJX19zdHJpbmdpZnkoV0FUQ0hE
T0dfTk9XQVlPVVQpICIpIik7DQo+IA0KPiAgc3RhdGljIGNvbnN0IHVuc2lnbmVkIHNob3J0IG5v
cm1hbF9pMmNbXSA9IHsNCj4gIAkweDJkLCAweDJlLCBJMkNfQ0xJRU5UX0VORA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9od21vbi9zY2g1Nnh4LWNvbW1vbi5jIGIvZHJpdmVycy9od21vbi9zY2g1
Nnh4LQ0KPiBjb21tb24uYyBpbmRleCBhMzg1YWFlM2JiMGYuLmZlYmI4YmE3ZGMyYyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9od21vbi9zY2g1Nnh4LWNvbW1vbi5jDQo+ICsrKyBiL2RyaXZlcnMv
aHdtb24vc2NoNTZ4eC1jb21tb24uYw0KPiBAQCAtMTgsMTMgKzE4LDE0IEBADQo+ICAjaW5jbHVk
ZSA8bGludXgvd2F0Y2hkb2cuaD4NCj4gICNpbmNsdWRlIDxsaW51eC91YWNjZXNzLmg+DQo+ICAj
aW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3N0cmluZ2lmeS5oPg0K
PiAgI2luY2x1ZGUgInNjaDU2eHgtY29tbW9uLmgiDQo+IA0KPiAgLyogSW5zbW9kIHBhcmFtZXRl
cnMgKi8NCj4gIHN0YXRpYyBib29sIG5vd2F5b3V0ID0gV0FUQ0hET0dfTk9XQVlPVVQ7ICBtb2R1
bGVfcGFyYW0obm93YXlvdXQsDQo+IGJvb2wsIDApOyAgTU9EVUxFX1BBUk1fREVTQyhub3dheW91
dCwgIldhdGNoZG9nIGNhbm5vdCBiZSBzdG9wcGVkIG9uY2UNCj4gc3RhcnRlZCAoZGVmYXVsdD0i
DQo+IC0JX19NT0RVTEVfU1RSSU5HKFdBVENIRE9HX05PV0FZT1VUKSAiKSIpOw0KPiArCV9fc3Ry
aW5naWZ5KFdBVENIRE9HX05PV0FZT1VUKSAiKSIpOw0KPiANCj4gICNkZWZpbmUgU0lPX1NDSDU2
WFhfTERfRU0JMHgwQwkvKiBFbWJlZGRlZCB1Q29udHJvbGxlciBMb2dpY2FsIERldg0KPiAqLw0K
PiAgI2RlZmluZSBTSU9fVU5MT0NLX0tFWQkJMHg1NQkvKiBLZXkgdG8gZW5hYmxlIFN1cGVyLUkv
TyAqLw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9od21vbi93ODM3OTMuYyBiL2RyaXZlcnMvaHdt
b24vdzgzNzkzLmMgaW5kZXgNCj4gYzZlZjA0YzY5ODU2Li5lMWYyNzA4YjVkYjYgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvaHdtb24vdzgzNzkzLmMNCj4gKysrIGIvZHJpdmVycy9od21vbi93ODM3
OTMuYw0KPiBAQCAtMzQsNiArMzQsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L25vdGlmaWVyLmg+
DQo+ICAjaW5jbHVkZSA8bGludXgvcmVib290Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvamlmZmll
cy5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3N0cmluZ2lmeS5oPg0KPiANCj4gIC8qIERlZmF1bHQg
dmFsdWVzICovDQo+ICAjZGVmaW5lIFdBVENIRE9HX1RJTUVPVVQgMgkvKiAyIG1pbnV0ZSBkZWZh
dWx0IHRpbWVvdXQgKi8NCj4gQEAgLTU3LDEzICs1OCwxMyBAQCBzdGF0aWMgaW50IHRpbWVvdXQg
PSBXQVRDSERPR19USU1FT1VUOwkvKg0KPiBkZWZhdWx0IHRpbWVvdXQgaW4gbWludXRlcyAqLw0K
PiAgbW9kdWxlX3BhcmFtKHRpbWVvdXQsIGludCwgMCk7DQo+ICBNT0RVTEVfUEFSTV9ERVNDKHRp
bWVvdXQsDQo+ICAJIldhdGNoZG9nIHRpbWVvdXQgaW4gbWludXRlcy4gMjw9IHRpbWVvdXQgPD0y
NTUgKGRlZmF1bHQ9Ig0KPiAtCQkJCV9fTU9EVUxFX1NUUklORyhXQVRDSERPR19USU1FT1VUKSAi
KSIpOw0KPiArCQkJCV9fc3RyaW5naWZ5KFdBVENIRE9HX1RJTUVPVVQpICIpIik7DQo+IA0KPiAg
c3RhdGljIGJvb2wgbm93YXlvdXQgPSBXQVRDSERPR19OT1dBWU9VVDsgIG1vZHVsZV9wYXJhbShu
b3dheW91dCwNCj4gYm9vbCwgMCk7ICBNT0RVTEVfUEFSTV9ERVNDKG5vd2F5b3V0LA0KPiAgCSJX
YXRjaGRvZyBjYW5ub3QgYmUgc3RvcHBlZCBvbmNlIHN0YXJ0ZWQgKGRlZmF1bHQ9Ig0KPiAtCQkJ
CV9fTU9EVUxFX1NUUklORyhXQVRDSERPR19OT1dBWU9VVCkgIikiKTsNCj4gKwkJCQlfX3N0cmlu
Z2lmeShXQVRDSERPR19OT1dBWU9VVCkgIikiKTsNCj4gDQo+ICAvKg0KPiAgICogQWRkcmVzcyAw
eDAwLCAweDBkLCAweDBlLCAweDBmIGluIGFsbCB0aHJlZSBiYW5rcyBhcmUgcmVzZXJ2ZWQNCj4g
DQo+IC0tDQo+IDIuNTUuMA0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxl
a3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=
