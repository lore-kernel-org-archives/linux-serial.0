Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022102.outbound.protection.outlook.com [52.101.53.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9304F5DE4;
	Tue, 13 Oct 2026 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909924; cv=fail; b=gaGcTHybFwMhrFGjjZaHjAvvAF2i85ZBDJA+kQUSFE7gM+9l2jGvhSzkSipYZs4+fYmLEsk5DCHRb2o3OqzMqLXNbEEpfj7254hK5pEaRkyJ6aCYQgB0bqpvtlaOhMVqST0dtR0vtxdUTydCofW441LPzXOa5450lDD3UfyBOhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909924; c=relaxed/simple;
	bh=4TIOACDuq0/IEWYGWzWr50U/ml8DSOB0Nlgzg3tDNBI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WSg/lz2zObKej4SuQcw4nQd049kokFGOjLTv3gaFw5EmAm6Jj0wH+f+Zy1Q9vg7t9PqT0I2lkzGOiq4IiQZjpYMIU4gO/xRYjwyuLfJXiNZsw2DcSew3TIUiq8YNgI/JArPBPF13/baMjITNgeTV7f1mGjpQzzIEjiRt/dFIx0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phil.gs; spf=pass smtp.mailfrom=phil.gs; dkim=pass (1024-bit key) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.b=pj3umdR0; arc=fail smtp.client-ip=52.101.53.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phil.gs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phil.gs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.b="pj3umdR0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkPxIi8RKafQTs27tfBGUQVPnVLKJBBY+jWqbhirmfzoq/pHRC14JUSp7ARr8cOEHdhEkt2CrEnHZg1gytTAw69M8obAALW9o9bZIUIc8tyASoCuRiQ4HvDdMQB1TUFDbEHGaCm1XfrUKT1H/lsBcZYDzlSWif+vSQB/8Wf3tvY0p9cBXICmlvArOl3rBxkQmQ9RrhyHwdsH3XxniUUV95vh6dXNS1ObLTX4eqY6mvlQxJQDfbGWRRBEyOUDD47OcO0hWc0M4QivakdnNC5SYrRfiO2BguyaPVCIcZ5xtxRSkFemANkyQ3FO84Xzdst/8fY2jbEEjKQM3mGIM3xBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TIOACDuq0/IEWYGWzWr50U/ml8DSOB0Nlgzg3tDNBI=;
 b=EqmCdEQiTaBj9fpAzLR3qOvSkoGn2cw+pflHXFwo0e+r0ZvWRXElNuV4wthmJy9cUJWIhAZ1YPy9IH6tVy1hOPpivTXpxHYLNxxruJY/BtR3oPd5mevFtNOeC4DCJOpxo7ULMqoxqn4ANQ8NkwkqIhnNMmnM0y19MKktCZrPLMQmjz2r8fFINtEHcrawRb1D1VxVtaDpLmiaBBCWw5ZCB4xP37OYJpfDupQKrcsa0DFbQ5d0Wqncow7sIz+EETj3/yq3xWwcMNxF65/qGceeCDzY+y/byyrRTMKzJTT5uAZS6ZMqc8NbCRwGNtTV8S5FcBY8L+86llYmtvM83oTZrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phil.gs; dmarc=pass action=none header.from=phil.gs; dkim=pass
 header.d=phil.gs; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORGFT5377951.onmicrosoft.com;
 s=selector1-NETORGFT5377951-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TIOACDuq0/IEWYGWzWr50U/ml8DSOB0Nlgzg3tDNBI=;
 b=pj3umdR0xGsJ30zwozokvwk9ugEloaOBlxsEugaR2hmmsjWNDEZEr+VMu9+bkBs2kAEgye/Y3wkBs37MCc7ELUCAu8jNpfW35sMbxnqirEwNL3hrvyLdOaBMGzGuWMw0PLjiCA52WTk4zQEsO69hVVI7+1EmO80k7FmOGIQzRQQ=
Received: from BY5PR04MB6472.namprd04.prod.outlook.com (2603:10b6:a03:1eb::10)
 by MN2PR04MB6480.namprd04.prod.outlook.com (2603:10b6:208:1ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 16:45:20 +0000
Received: from BY5PR04MB6472.namprd04.prod.outlook.com
 ([fe80::3a9:9dbc:2aeb:8827]) by BY5PR04MB6472.namprd04.prod.outlook.com
 ([fe80::3a9:9dbc:2aeb:8827%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 16:45:20 +0000
From: Phil Rosenthal <phil@phil.gs>
To: Igor Putko <igorpetindev@gmail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, Vignesh Raghavendra
	<vigneshr@ti.com>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	"syzbot+843bf2f48f4d12e6682e@syzkaller.appspotmail.com"
	<syzbot+843bf2f48f4d12e6682e@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] serial: core: shut down initialized port on removal
Thread-Topic: [PATCH v2] serial: core: shut down initialized port on removal
Thread-Index: AQHdWzI7lTtJ90aoekOCOah+Enw7Gw==
Date: Tue, 13 Oct 2026 16:45:20 +0000
Message-ID: <B3A8B8AA-AFE1-4545-A38B-DBB8BCC83830@phil.gs>
References: <20260924192224.3175-1-igorpetindev@gmail.com>
 <20261003163337.45577-1-igorpetindev@gmail.com>
In-Reply-To: <20261003163337.45577-1-igorpetindev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phil.gs;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6472:EE_|MN2PR04MB6480:EE_
x-ms-office365-filtering-correlation-id: a4d9a3b6-05ae-475b-a08d-08df29495e49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|23010399003|10067099003|22082099003|18002099003|38070700021|261009221227099003|261009223027099003|7055299009|4143699003|56012099006;
x-microsoft-antispam-message-info:
 j+t7wvUThM8VqJ1JaNh/v+EoUBUUhu9OMIJEsWj0JldgzKk815IkA8Z6g7PC6M7O6dFb4uhqSulkWm67x/Gd1R53YWHfKxrj9PAjZLlQ4MMJtTdVQ6m9tHHjzsECUpDSGIdhsCCQFWAtoKZiQOPBoteDR3oOzVXvq4X9l8A8OQmL7X/hkoLhStkkRd0qTYQX9dVKjqSzhhlIj1iT06D8s+J1ok8eRRKayDyfN98JjCa5ut38lO+O0Fcl4zE+FngEI3PN+KWX2378hZ7L6KNnlSVYnpHOwC/eFM/GNYB5mFC3gyfl9LJ++l8Nu48xOMQw7I8YKaJ8ZEh9njWMW40TtDKdmghRf+0622q3LiSPJ/cvq4LR/sosb3bTnnVaTgsIEchYCtCXGNvD0W+o0mcgAkhFuMgQOxhLyXFgnEVxVaI7AyMxIW7uLh/0pUFG+/zBHXDMdOWo0P8LBs2aAfJkqSl6HgY4Vh4N9J62WFRD9cKH8LNRau2CTTr0GfilO4FqeY//YZalpeGLfaS5x5mQnZPITmWZZcpefDaszF+G2nF7dxiv6FDbfNX7RUyRXCLFWlQ0oaeAuhlkfDhmq6j0aZ0YCaHWtA58REaGbFrmBiOh/bPO/CCoP+cd3Q2ZId2TFezCJHzo+Nq5lnJu2PdthZo9g0VaPvJQLBpFYm2+jLZf6vCP0PnjnSW3x0riEnWjMUy6hFvWsEKmPregkRcmjg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6472.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(23010399003)(10067099003)(22082099003)(18002099003)(38070700021)(261009221227099003)(261009223027099003)(7055299009)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j7cY3ewS+P4bgPU76KK609IAv9ZQ8dtCY24p6OYgiyUHoLQCh1C424x8txI7?=
 =?us-ascii?Q?GENftAdmm1MFszVCOsYNKStRvQ4rAdkGWzP8SQpIwmdYwCdLSAMMBcsLr1Hr?=
 =?us-ascii?Q?E0COj6H5pExbt9h5m3wOVU6ZF6bzbVfUuEm8d96d0Qbfywp8Ys856Ko9W0Md?=
 =?us-ascii?Q?OasFf5VlQxbkmS7fJiupiEuPU7NwOPWcobfKMDW0T1sAtZ09jPE/+Zh+T8Mc?=
 =?us-ascii?Q?/9+DkdeWWO4sbnRg4JocQWXUrmd3axSZ7a3DLCWOzTX1iLpVs3ifrPHaOkIs?=
 =?us-ascii?Q?KEg+aS137N2LIZ9wcpyagudElJcMeg0Ifzsu8MisnTQqdBihph/eNQ7OkBZ4?=
 =?us-ascii?Q?VYbwu7PtIKZs4eexnigY2QrphEMBtfB2geEYhbKqmXMyWbuLYJ5A4fAJD6V+?=
 =?us-ascii?Q?74VZpr5mXFhgBuz9tieFgFvHd/S2XHc6Net1MUU4EZD+ZqTxheLER4q092A2?=
 =?us-ascii?Q?UAQGDmlUdRuPUz7+jRcC0h8RY/3pX4xdttf9sGaafmd/RbAaMpvWFM9VLRUn?=
 =?us-ascii?Q?Oje7ksdv6BkM3imes9yoKdV8B8YVdpkq/iOtoljbo0pWJHU+Qc1HfF8HuBjP?=
 =?us-ascii?Q?v+uoVnRjnMr26JK/B3bgF4F6dEXZy1KeGQxyYQoCQ3oWJAiIfKAq13bCJuGH?=
 =?us-ascii?Q?ohLqvUob5CvQ4zfPPs6T+P+ZCupd2Dpan+CdpcPAo7sZtYDT2b8A40wFNSg4?=
 =?us-ascii?Q?PViX7UXtp/9MknvGJb9ms2BlOpyKmDip7wlvjguHAX4RTBjCSGBatpb3fiFc?=
 =?us-ascii?Q?lOPXAcGvB1jM1+SUs1DNaM+QF1Zca3Ax8WFDNouJmVDprv16I5Hgz4JTZDDV?=
 =?us-ascii?Q?/P5Xr5riguFNDGzLogFX7PN+U+s/NSwnF8E9zJYkfP5p3QQjcfqPfESUo0mW?=
 =?us-ascii?Q?LbUuy7M6xzLQMw2yMaT4fZNtg657QeRexuHNoinVE+KMdQblcLAseOqxUyvx?=
 =?us-ascii?Q?lb88PcP+vsWrYZKSCWIAndfeNqGCX5v9JGSAxvDxfIizD3xvSlnescIqftWk?=
 =?us-ascii?Q?1jF45b4U91PjstrlcvzaTWk59JRn85i3vh97pKQhGhHFKVvX4ic1+8gaYdHq?=
 =?us-ascii?Q?ZuP6SPJ7qfkEnLK2NEJcrYd6VLL6D6F9CfhuUXIfvegYu9+0nc9GawxfInlt?=
 =?us-ascii?Q?tHK/ObazmguI7IV1EViCIq9Sbx1fB9x2uQXBhqXzAoBCQZUO9F/nNIJ+DAyr?=
 =?us-ascii?Q?YxcNUX1SupWs6kODAjLnt2wzlE74m2wTvvvqpWJWIAy8pFt6gTjEXOst86SY?=
 =?us-ascii?Q?eq8aKvnHXswYiNUJcTp28oMXgLC3ZQuz/bMJdREQjuZpZkcVg5NEOWNG18ox?=
 =?us-ascii?Q?K2GWzxhXDFxjjAaAxktZ8/Xh3ZJQ1Pdw+ukkfMtnoEPYxrjVDo1StEBow7HQ?=
 =?us-ascii?Q?2oKUWYtveXrP8GtQhUPfH1W3tyTuXg/wVoqBrbX9k0Ot37PdMllz+gItqvvn?=
 =?us-ascii?Q?0wq7Q0JlsIrdKttxqr6S+L6CtSPTJB2pgT9P30Af5Q5dheA+9RjU2noOVVKo?=
 =?us-ascii?Q?zPxU9s9MYfq1CFnsuZc58K2RIt3WFGk/5oW7nG9+NKxNQ7BUHlOsDPMkK2MF?=
 =?us-ascii?Q?Jd7I86OP27hKSkUe5QPMIv3wVRVzioTuGQmeEAZCbm9tXYDUz6G2YAM5Ykd9?=
 =?us-ascii?Q?7RoNBN2Cn8bvXAXMypcEtqz4lFZbQxNe6rzlCySoBgPLUM6WD+44lIfCyroj?=
 =?us-ascii?Q?5npizZHdJUxwwxVFpSxV4zU3P0s/xpg0DgKoJHpBPnXAkP8b?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9701346C7DAC8A42B21AA3E54D542078@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phil.gs
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6472.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d9a3b6-05ae-475b-a08d-08df29495e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 16:45:20.0859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 47d4f979-ea6f-4fcb-aea9-39371d64bc6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tE+U12TJ+oR9efTRclmP6c0Ap9U8/c/FtnzkQLDCJ+UPLghCs5jSy/o76Ra0jodZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6480

On Sat, Oct 03, 2026 at 07:33:37PM +0300, Igor Putko wrote:
> Fix this by acquiring port->mutex in serial_core_remove_one_port() after
> console unregistration, clearing port->console under the mutex to prevent
> data races with concurrent tty_port_shutdown(), and invoking
> uart_shutdown(NULL, state) if the port remains initialized.

I sent a patch for the same bug [1] without having seen this one. I
ran my reproducers on tty-next 36844ea19656 plus this commit
(810d467c11f0 in tty-testing), in a QEMU guest with KASAN. The 8250_pci
case with INTx is fixed: the IRQ is freed on unbind, reading
/proc/interrupts is clean and rebinding restores the console. It also
fixes a second symptom, on a polled port (irq 0, UPF_IOREMAP), where
serial8250_timeout() kept running after removal and dereferenced the
cleared membase. A port held open across removal and a console that
was never opened still work.

Tested-by: Phil Rosenthal <phil@phil.gs>

The patch uses scoped_guard(), which exists for mutexes from v6.5, so
it won't build on the 6.1, 5.15 and 5.10 stable trees. If you don't
plan to send backports for those, I can.

[1] https://lore.kernel.org/r/20261013-serial-console-remove-v2-1-2eca1a92c=
10d@phil.gs

Thanks,
Phil

