Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CC855E49;
	Tue,  7 May 2024 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715114629; cv=fail; b=pIZurdGR5nVfmqdzUl9L4c6ahCd6N3BUsO1OTBXSv2E2ig7LYxNVo8jlBmGPc/umqTBIdtbckLdxP2nnvC/Cj4fPwZ/CK4majX8BDEoDODvq9HFqY9SQ6TI0TQWm0+wN/I0w4uOQ6PKLtWKWhO7JuQRFzWLYSVNSGUjWkJnPZjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715114629; c=relaxed/simple;
	bh=cbqJ8B8zoNb1wL5cvsafYdWHOXGpucToAPhTV87jaLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZvywap+pAQ+QDo+8xeArLaSVASrddHaZqINo5ceonBAF4OGzjUTHjcd1csa+DY8Br1f+PrV7ta3dxO2NDwqFxYzAWMMCKK423ZWIvdD841Ar209q2CvNp6ze1as1GoAoLa7go0h5XOf203Tiv7OLNlkJGRiM9MPY6h8VEVyHD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KEeC78Kb; arc=fail smtp.client-ip=40.107.247.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KEeC78Kb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JT63jHcqZosZuArGmoNBrJ1QKnNldSCignaLiEzOxMCjVsOw5fZiezFBkKM3Bz46UgYvyYDuNM7m5ZqUn9jmZB+E4oE7zf4X1beNRzbRbdukS2iBoS4l7GXDzetHF198kGBFuGJdCiiCAN5MA5hnwUn7ZIkYJqkDRWtexvwSbKPTAViKsEAZEj3reeB177W4Y16VhKjkai41i0Wv1hZjoo466KhoAkwBVMfxyJsj2lfrCA5D9NDxTf3VqGZwy4roHOgRYvx6KzS/LEeGQ4eHdDoe34DEvyLk3Eta9oQHWbvbgTp7gV/ETSERNrAtdDJ1d543XlpVFGZiSjw/llYAGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcAD7n5DFC8zY5SMsqG6DN1S/Q3hAt3IaNHuvXjxowM=;
 b=dNfifWnUvNNlNFTWXN+JCjWyB/bxC5n0BFkI8yvMO+SVmO2ZXt6Y1aZiUdYxnB+UsatjhpGo2upL4NTFKZTjM/JiU4bO3s7ioMX0TG0bjapXKqQa8iCwHNW98rWVBBoIsMT2liGBWt40S2Ty39gV1i0rd/tU97DKKJK25FaYxOvT0gYAbWyjnH4YLBcuBZWDcPIePyC2Us749CUkN0vL6nXGEW3qIWpop0XUUw+FJciOqtf8GRkhTiV7BjGIj5PTgMDp+1rwNIw+nf0YUYSQdJ8jpTK46cIVHk6DSX03SrjhW7E3tgrnz9tO3/TVvEZ6VyqFyGHZOQYe1vy1t//VOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcAD7n5DFC8zY5SMsqG6DN1S/Q3hAt3IaNHuvXjxowM=;
 b=KEeC78KbFcDgJi1AoOqK+4q3L3O+OBbF7Dv8+AYsW6MIZvnZNQtZAVM7XUAR0E//nEZAN4TNX/hAOebXuyuu/h8/oX5t+v6N58HuDf9ipEozGFhIsN5v0LsraeSzzlLnJ6i6KGxma5YSglA87KSbHZ5xFc/Kc7ZSbQt2sRegpj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8576.eurprd04.prod.outlook.com (2603:10a6:102:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 7 May
 2024 20:43:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 20:43:43 +0000
From: Frank Li <Frank.Li@nxp.com>
To: alexandre.belloni@bootlin.com
Cc: conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH resend v9 3/8] Documentation: i3c: Add I3C target mode controller and function
Date: Tue,  7 May 2024 16:43:06 -0400
Message-Id: <20240507204311.2898714-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507204311.2898714-1-Frank.Li@nxp.com>
References: <20240507204311.2898714-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d49770-8ca0-446e-11df-08dc6ed66249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|376005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ya6b/pVjGMaKz01JUkZsDMDYqMugyhTxnaO45a2pPtfJrMVT3lb9t7oSP1fy?=
 =?us-ascii?Q?UM0L8KYrv+kMzkEfo3DOhTNuf6aBa9yjJGpjz41BSPhMn2EXEmWH7kz+WDQ+?=
 =?us-ascii?Q?oHDF/beY2ogVytaHADXe7kmDUbz7HO29dH5xV7nMvWSyAkKQTg05t2PON2oD?=
 =?us-ascii?Q?9p04kKiZu+cR5pxd3NGi6/xxlmTL/biTqBTQP6Mt1n7WuKcWCkG9hQNN+Gnm?=
 =?us-ascii?Q?Pg8vNTy3WJy5yvp3sD0qu2XKSucn5+fuUjkCHa6VWWm7HA/7pkzl5DYI7Apd?=
 =?us-ascii?Q?iomxZwASTY+b5iVm/ruZJ446jKSsonA9sL327NuJ042x4ijVqzWiJawueD2I?=
 =?us-ascii?Q?1Nx5X8AXlPRrEV9TYDjg5whK4fkb8AuEOZFzk3RCXC5MFtcbA9cMUiMZK+nd?=
 =?us-ascii?Q?tk4tlGDJfVqVgmH8PDWydHZ7oQIg2bYftjrcI145JpbekYh/nvtwWri9mW0l?=
 =?us-ascii?Q?YZd5lmSxWwNNyjRYKcMffOIp501pxIWWqYMlN4ukPau+xuBW+wQ+W6KWRPgy?=
 =?us-ascii?Q?e016q/YtW1DfnQ8L/Tuh4V8+pcYFnrXzzayAWZ74Vz8QTxa6hY3yRQ5vbP6V?=
 =?us-ascii?Q?yXbTEvQ7VicXxDro2hOs5SXqFNVXRqhw7ULgC1/JBGZgqTvp5wDHGHuxoXVM?=
 =?us-ascii?Q?WjTpWcBlbzKMbQCJoNyQa2NOL99PBnUogpKi6hmCe+G60PTTEaOTGgMhtxB5?=
 =?us-ascii?Q?lN6VF6qodSoSDEgKOqiX3+CK49vnNwv9znqEe0PJKnLKSC17rvofRhHUwryM?=
 =?us-ascii?Q?5S/xNVVIPDww/pdPYuTtJ+UCKIeJY2VROiuS/vAJPkHDl4taDaFZaXBOLiiw?=
 =?us-ascii?Q?CeT1qcnbyrprojluxWmcCFVKAJ/T/Wp+ruwgFlrEcmT3xT9pN6a672PELLYp?=
 =?us-ascii?Q?1d6SFC8W6NOauRgFs0N+Q0gwNIwpGqWshwSxnMGU7nenYZqWxNznRjPR1LwV?=
 =?us-ascii?Q?rhg+w1W7CRDY+lW7AUs6z1bfterMpF4oGBeFZQLnYjtVkgTh5dluUWOu1TXU?=
 =?us-ascii?Q?7LoJPGd0zv/zrcXTZYsAir3WvtzFNogC4vfzRf/ZFWb4RIgQfDzJFA1IJeNz?=
 =?us-ascii?Q?BFJyJI/QtzF7c8A47Hz+D6btgw7rhewb3W0HgLso5NFdVy800F5C/IfFhN1S?=
 =?us-ascii?Q?MqoiQwfWa8BRHSV6eN8p0GFpjPsgKnPiImpmhQbcP7I08cpFmNOY8A5A+c3B?=
 =?us-ascii?Q?xm82wCKMum1HTQxrDTVSOMWcVGVP/EtZEwXWBnTN9CpMbTLbMhPEw6Ib/tRT?=
 =?us-ascii?Q?Gotz1OQG+99IhPn28++cZoCpMclciN80z8eMS80SK2xp0kEXveTlC20UiqpU?=
 =?us-ascii?Q?+DwHX2uURDLZUQwoZdLqV16dgjcwAA5f8bLEylk0HsmTjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oYstW1mDrHdoo3DznfVK/Kxuc3MhssqUPQZqXZskLhWRbSZ12q3qBEaWPUpJ?=
 =?us-ascii?Q?rvLSmzvzplw2Dfimbgz3v52zmgw/eKXgvAMHO2MrchDEhkXQlVVYM1xmz7mv?=
 =?us-ascii?Q?ZgAqAxpbk2KZHHlyMSUYrDAcAeiM1ogsvmrQ3jgvUF0hJc4GbPfg8F1C0vfp?=
 =?us-ascii?Q?gZ4ysMYfagsuyngqwmWXP+QI0eJTkweam99UX3XTI9PiRMCj8pPU+Fn4wWo1?=
 =?us-ascii?Q?PzTmdIfK+rVzpYHTRHR3+5v/yWtfeu4iHIP/edSZda7/PGF53PW+HI5CyI+E?=
 =?us-ascii?Q?5ovGrOFq38JLYiHMGLFYTD8IAEZSPMW/Fbn6A8BCWncY3JuGBWzVMZAGKCOx?=
 =?us-ascii?Q?3b2DqiA05tVykDLcS9W9S7OUomoYjPdaVY8h6mIYhPTJdhbIeK+zpAZ6s/ww?=
 =?us-ascii?Q?LaH1qJ4SF8f6Jw+42bKpYELtB+Lstlc6Pq3sTBQJKVnqEmcIJQO+UvbvWFbF?=
 =?us-ascii?Q?lhHx7GkSvcGcbnp4f4kbVZeZ3SqHiIrOmKvEWnvdOkARRdWoyC34f3mls/X6?=
 =?us-ascii?Q?+znZJ8knkstSaAnl5p0FgA65yVhlChsrd0YJ0jpnZJghiINnJuxginSA/rva?=
 =?us-ascii?Q?NvAbqBvuNcdfLypqfFfswIHHXcrWSjdgBhw9M4m2/JB4Q/NSkIrEmVN3QqSf?=
 =?us-ascii?Q?hdmH5I4FC5Olo+Sy/Hb7gFjj2M3ZepH8g/qbBM/QdNyYs82i4oBoFELaEurK?=
 =?us-ascii?Q?+6xJ0B3Qm7rRhLyhAbieIoy3JbISI1uMZgjHIdYUi0RZQPgQhX4UeuPm+CRv?=
 =?us-ascii?Q?9LW2sMmZ7pIOUa96a8WL24cK6x6N0xUJyh9AF2vvQXbQFAqyD/77oko+7ogU?=
 =?us-ascii?Q?e5dKpAjIuf2FbiBxAmTGw1+e9ywqa//XwoydyprHUWiSSkd/afOOjr1V/wfM?=
 =?us-ascii?Q?ybeL8zlHpIGxtEEBIsr2/WVerP03j9y9xLkR4C1MBFwx45rpyVADzIMaf82j?=
 =?us-ascii?Q?4f7TbYrAWQZYzFl1KcAyqzAArMxmGY23vJ5kdkJGOqbOBlnFWW33BDRgexAU?=
 =?us-ascii?Q?WZzRY1TmCavZxFRUbcWHnPAVA7pEvoDraS2gHZ8WURQIvFSlVPWmEkhz/8Re?=
 =?us-ascii?Q?B4c3CPXNMzUgQcgE0uizvlJCMHGoWGskwjLPWsi9465SGJi8m6ZYg+eVVuMx?=
 =?us-ascii?Q?MlBZcqEhRh6/LVJdjces3IjzbOmmiVW3fawxBxdUKz+svCjtwy7Zlwsj16Fa?=
 =?us-ascii?Q?rO1qjB3MaFuTzZBLuQX4iLv9XNPP74K+wV7+v2ccj10sTpaV8nbFJs7u08it?=
 =?us-ascii?Q?BAKvZaE03QNNUIPUg43+/QOl15qGVQ5kMMnhYRgvmhQLFgCDTfOaHKX33wZ9?=
 =?us-ascii?Q?Yb8u+NcdEPPx0TXWPU27dA0o18H5KG6dgjm+L295A/c6k+HJdK6oIWbVmdaY?=
 =?us-ascii?Q?7F0xgbjYhnjbHh3VxOoTetQ7vMfpIOx1v1QNpmuIRlAHF6u/Nxf1F6tTWsJK?=
 =?us-ascii?Q?DML5DdEHlzMhIYv5s0bgbwIQIJIbhVjVQNX9k/ySxqYrB0h6yVX0T03YXqF0?=
 =?us-ascii?Q?/goW5oUvgIkkdoYYpbYlmQaGAqIXtCBx11aIJJxkDoA7DBVWluZASVtQXUkR?=
 =?us-ascii?Q?I3dt0PhDABYHu212nYOdDZRVw587sd8zS4/HgAz6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d49770-8ca0-446e-11df-08dc6ed66249
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 20:43:43.2333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTAOWJ8y0sal7O/EPsFnpCTUjzzoIQAN6n/1zW9Q8rOtzBLPtXOFpChO+pieYnvkFBAxE6EZ97UkLKRI+efWTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8576

Add I3C target mode and tty over i3c func driver document.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/driver-api/i3c/index.rst        |   1 +
 .../driver-api/i3c/target/i3c-target-cfs.rst  | 109 ++++++++++
 .../driver-api/i3c/target/i3c-target.rst      | 189 ++++++++++++++++++
 .../driver-api/i3c/target/i3c-tty-howto.rst   | 109 ++++++++++
 Documentation/driver-api/i3c/target/index.rst |  13 ++
 5 files changed, 421 insertions(+)
 create mode 100644 Documentation/driver-api/i3c/target/i3c-target-cfs.rst
 create mode 100644 Documentation/driver-api/i3c/target/i3c-target.rst
 create mode 100644 Documentation/driver-api/i3c/target/i3c-tty-howto.rst
 create mode 100644 Documentation/driver-api/i3c/target/index.rst

diff --git a/Documentation/driver-api/i3c/index.rst b/Documentation/driver-api/i3c/index.rst
index 783d6dad054b6..345a43c9f61b0 100644
--- a/Documentation/driver-api/i3c/index.rst
+++ b/Documentation/driver-api/i3c/index.rst
@@ -9,3 +9,4 @@ I3C subsystem
    protocol
    device-driver-api
    master-driver-api
+   target/index
diff --git a/Documentation/driver-api/i3c/target/i3c-target-cfs.rst b/Documentation/driver-api/i3c/target/i3c-target-cfs.rst
new file mode 100644
index 0000000000000..1fcf829dc4ae2
--- /dev/null
+++ b/Documentation/driver-api/i3c/target/i3c-target-cfs.rst
@@ -0,0 +1,109 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+Configuring I3C Target Using CONFIGFS
+=======================================
+
+:Author: Frank Li <Frank.Li@nxp.com>
+
+The I3C Target Core exposes configfs entry (i3c_target) to configure the I3C
+target function and to bind the target function with the target controller.
+(For introducing other mechanisms to configure the I3C Target Function refer to
+[1]).
+
+Mounting configfs
+=================
+
+The I3C Target Core layer creates i3c_target directory in the mounted configfs
+directory. configfs can be mounted using the following command::
+
+	mount -t configfs none /sys/kernel/config
+
+Directory Structure
+===================
+
+The i3c_target configfs has two directories at its root: controllers and
+functions. Every Controller device present in the system will have an entry in
+the *controllers* directory and every Function driver present in the system will
+have an entry in the *functions* directory.
+::
+
+	/sys/kernel/config/i3c_target/
+		.. controllers/
+		.. functions/
+
+Creating Function Device
+===================
+
+Every registered Function driver will be listed in controllers directory. The
+entries corresponding to Function driver will be created by the Function core.
+::
+
+	/sys/kernel/config/i3c_target/functions/
+		.. <Function Driver1>/
+			... <Function Device 11>/
+			... <Function Device 21>/
+			... <Function Device 31>/
+		.. <Function Driver2>/
+			... <Function Device 12>/
+			... <Function Device 22>/
+
+In order to create a <Function device> of the type probed by <Function Driver>,
+the user has to create a directory inside <Function DriverN>.
+
+Every <Function device> directory consists of the following entries that can be
+used to configure the standard configuration header of the target function.
+(These entries are created by the framework when any new <Function Device> is
+created)
+::
+
+		.. <Function Driver1>/
+			... <Function Device 11>/
+				... vendor_id
+				... part_id
+				... bcr
+				... dcr
+				... ext_id
+				... instance_id
+				... max_read_len
+				... max_write_len
+				... vendor_info
+
+Controller Device
+==========
+
+Every registered Controller device will be listed in controllers directory. The
+entries corresponding to Controller device will be created by the Controller
+core.
+::
+
+	/sys/kernel/config/i3c_target/controllers/
+		.. <Controller Device1>/
+			... <Symlink Function Device11>/
+		.. <Controller Device2>/
+			... <Symlink Function Device21>/
+
+The <Controller Device> directory will have a list of symbolic links to
+<Function Device>. These symbolic links should be created by the user to
+represent the functions present in the target device. Only <Function Device>
+that represents a physical function can be linked to a Controller device.
+
+::
+
+			 | controllers/
+				| <Directory: Controller name>/
+					| <Symbolic Link: Function>
+			 | functions/
+				| <Directory: Function driver>/
+					| <Directory: Function device>/
+						| vendor_id
+						| part_id
+						| bcr
+						| dcr
+						| ext_id
+						| instance_id
+						| max_read_len
+						| max_write_len
+						| vendor_info
+
+[1] Documentation/I3C/target/pci-target.rst
diff --git a/Documentation/driver-api/i3c/target/i3c-target.rst b/Documentation/driver-api/i3c/target/i3c-target.rst
new file mode 100644
index 0000000000000..09ae26b1f311a
--- /dev/null
+++ b/Documentation/driver-api/i3c/target/i3c-target.rst
@@ -0,0 +1,189 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Author: Frank Li <Frank.Li@nxp.com>
+
+This document is a guide to use the I3C Target Framework in order to create
+target controller driver, target function driver, and using configfs interface
+to bind the function driver to the controller driver.
+
+Introduction
+============
+
+Linux has a comprehensive I3C subsystem to support I3C controllers that
+operates in master mode. The subsystem has capability to scan I3C bus,assign
+i3c device address, load I3C driver (based on Manufacturer ID, part ID),
+support other services like hot-join, In-Band Interrupt(IBI).
+
+However the I3C controller IP integrated in some SoCs is capable of operating
+either in Master mode or Target mode. I3C Target Framework will add target mode
+support in Linux. This will help to run Linux in an target system which can
+have a wide variety of use cases from testing or validation, co-processor
+accelerator, etc.
+
+I3C Target Core
+=================
+
+The I3C Target Core layer comprises 3 components: the Target Controller
+library, the Target Function library, and the configfs layer to bind the target
+function with the target controller.
+
+I3C Target Controller Library
+------------------------------------
+
+The Controller library provides APIs to be used by the controller that can
+operate in target mode. It also provides APIs to be used by function
+driver/library in order to implement a particular target function.
+
+APIs for the I3C Target controller Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This section lists the APIs that the I3C Target core provides to be used by the
+I3C controller driver.
+
+* devm_i3c_target_ctrl_create()/i3c_target_ctrl_create()
+
+   The I3C controller driver should implement the following ops:
+
+	* set_config: ops to set i3c configuration
+	* enable: ops to enable controller
+	* disable: ops to disable controller
+	* raise_ibi: ops to raise IBI to master controller
+	* alloc_request: ops to alloc a transfer request
+	* free_request: ops to free a transfer request
+	* queue: ops to queue a request to transfer queue
+	* dequeue: ops to dequeue a request from transfer queue
+	* cancel_all_reqs: ops to cancel all request from transfer queue
+        * fifo_status: ops to get fifo status
+        * fifo_flush: ops to flush hardware fifo
+	* get_features: ops to get controller supported features
+
+   The I3C controller driver can then create a new Controller device by
+   invoking devm_i3c_target_ctrl_create()/i3c_target_ctrl_create().
+
+* devm_i3c_target_ctrl_destroy()/i3c_target_ctrl_destroy()
+
+   The I3C controller driver can destroy the Controller device created by
+   either devm_i3c_target_ctrl_create() or i3c_target_ctrl_create() using
+   devm_i3c_target_ctrl_destroy() or i3c_target_ctrl_destroy().
+
+I3C Target Controller APIs for the I3C Target Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This section lists the APIs that the I3C Target core provides to be used by the
+I3C target function driver.
+
+* i3c_target_ctrl_set_config()
+
+   The I3C target function driver should use i3c_target_ctrl_set_config() to
+   write i3c configuration to the target controller.
+
+* i3c_target_ctrl_enable()/i3c_target_ctrl_disable()
+
+   The I3C target function driver should use i3c_target_ctrl_enable()/
+   i3c_target_ctrl_disable() to enable/disable i3c target controller.
+
+* i3c_target_ctrl_alloc_request()/i3c_target_ctrl_free_request()
+
+   The I3C target function driver should usei3c_target_ctrl_alloc_request() /
+   i3c_target_ctrl_free_request() to alloc/free a i3c request.
+
+* i3c_target_ctrl_raise_ibi()
+
+   The I3C target function driver should use i3c_target_ctrl_raise_ibi() to
+   raise IBI.
+
+* i3c_target_ctrl_queue()/i3c_target_ctrl_dequeue()
+
+   The I3C target function driver should use i3c_target_ctrl_queue()/
+   i3c_target_ctrl_dequeue(), to queue/dequeue I3C transfer to/from transfer
+   queue.
+
+* i3c_target_ctrl_get_features()
+
+   The I3C target function driver should use i3c_target_ctrl_get_features() to
+   get I3C target controller supported features.
+
+Other I3C Target Controller APIs
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+There are other APIs provided by the Controller library. These are used for
+binding the I3C Target Function device with Controlller device. i3c-cfs.c can
+be used as reference for using these APIs.
+
+* i3c_target_ctrl_get()
+
+   Get a reference to the I3C target controller based on the device name of
+   the controller.
+
+* i3c_target_ctrl_put()
+
+   Release the reference to the I3C target controller obtained using
+   i3c_target_ctrl_get()
+
+* i3c_target_ctrl_add_func()
+
+   Add a I3C target function to a I3C target controller.
+
+* i3c_target_ctrl_remove_func()
+
+   Remove the I3C target function from I3C target controller.
+
+I3C Target Function Library
+----------------------------------
+
+The I3C Target Function library provides APIs to be used by the function driver
+and the Controller library to provide target mode functionality.
+
+I3C Target Function APIs for the I3C Target Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This section lists the APIs that the I3C Target core provides to be used
+by the I3C target function driver.
+
+* i3c_target_func_register_driver()
+
+   The I3C Target Function driver should implement the following ops:
+	 * bind: ops to perform when a Controller device has been bound to
+	   Function device
+	 * unbind: ops to perform when a binding has been lost between a
+	   Controller device and Function device
+
+  The I3C Function driver can then register the I3C Function driver by using
+  i3c_target_func_register_driver().
+
+* i3c_target_func_unregister_driver()
+
+  The I3C Function driver can unregister the I3C Function driver by using
+  i3c_epf_unregister_driver().
+
+APIs for the I3C Target Controller Library
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This section lists the APIs that the I3C Target core provides to be used by the
+I3C target controller library.
+
+Other I3C Target APIs
+~~~~~~~~~~~~~~~~~~~~
+
+There are other APIs provided by the Function library. These are used to notify
+the function driver when the Function device is bound to the EPC device.
+i3c-cfs.c can be used as reference for using these APIs.
+
+* i3c_target_func_create()
+
+   Create a new I3C Function device by passing the name of the I3C EPF device.
+   This name will be used to bind the Function device to a Function driver.
+
+* i3c_target_func_destroy()
+
+   Destroy the created I3C Function device.
+
+* i3c_target_func_bind()
+
+   i3c_target_func_bind() should be invoked when the EPF device has been bound
+   to a Controller device.
+
+* i3c_target_func_unbind()
+
+   i3c_target_func_unbind() should be invoked when the binding between EPC
+   device and function device is lost.
diff --git a/Documentation/driver-api/i3c/target/i3c-tty-howto.rst b/Documentation/driver-api/i3c/target/i3c-tty-howto.rst
new file mode 100644
index 0000000000000..43a129b18e938
--- /dev/null
+++ b/Documentation/driver-api/i3c/target/i3c-tty-howto.rst
@@ -0,0 +1,109 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================
+I3C TTY User Guide
+===================
+
+:Author: Frank Li <Frank.Li@nxp.com>
+
+This document is a guide to help users use i3c-target-tty function driver and
+i3ctty master driver for testing I3C. The list of steps to be followed in the
+master side and target side is given below.
+
+Endpoint Device
+===============
+
+Endpoint Controller Devices
+---------------------------
+
+To find the list of target controller devices in the system::
+
+	# ls  /sys/class/i3c_target/
+	  44330000.i3c-target
+
+If CONFIG_I3C_SLAVE_CONFIGFS is enabled::
+
+	# ls /sys/kernel/config/i3c_target/controllers/
+	  44330000.i3c-target
+
+
+Endpoint Function Drivers
+-------------------------
+
+To find the list of target function drivers in the system::
+
+	# ls /sys/bus/i3c_target_func/drivers
+	  tty
+
+If CONFIG_I3C_SLAVE_CONFIGFS is enabled::
+
+	# ls /sys/kernel/config/i3c_target/functions
+	  tty
+
+
+Creating i3c-target-tty Device
+----------------------------
+
+I3C target function device can be created using the configfs. To create
+i3c-target-tty device, the following commands can be used::
+
+	# mount -t configfs none /sys/kernel/config
+	# cd /sys/kernel/config/i3c_target/
+	# mkdir functions/tty/func1
+
+The "mkdir func1" above creates the i3c-target-tty function device that will
+be probed by i3c tty driver.
+
+The I3C target framework populates the directory with the following
+configurable fields::
+
+	# ls functions/tty/func1
+	bcr  dcr  ext_id  instance_id  max_read_len  max_write_len
+	part_id  vendor_id  vendor_info
+
+The I3C target function driver populates these entries with default values when
+the device is bound to the driver. The i3c-target-tty driver populates vendorid
+with 0xffff and interrupt_pin with 0x0001::
+
+	# cat functions/tty/func1/vendor_id
+	  0x0
+
+Configuring i3c-target-tty Device
+-------------------------------
+
+The user can configure the i3c-target-tty device using configfs entry. In order
+to change the vendorid, the following commands can be used::
+
+	# echo 0x011b > functions/tty/func1/vendor_id
+	# echo 0x1000 > functions/tty/func1/part_id
+	# echo 0x6 > functions/tty/t/bcr
+
+Binding i3c-target-tty Device to target Controller
+------------------------------------------------
+
+In order for the target function device to be useful, it has to be bound to a
+I3C target controller driver. Use the configfs to bind the function device to
+one of the controller driver present in the system::
+
+	# ln -s functions/tty/func1 controllers/44330000.i3c-target/
+
+I3C Master Device
+================
+
+Check I3C tty device is probed
+
+	# ls /sys/bus/i3c/devices/0-23610000000
+	0-23610000000:0  bcr  dcr  driver  dynamic_address  hdrcap
+	modalias  pid  power  subsystem  tty  uevent
+
+Using Target TTY function Device
+-----------------------------------
+
+Host side:
+	cat /dev/ttyI3C0
+Target side
+	echo abc >/dev/ttyI3C0
+
+You will see "abc" show at console.
+
+You can use other tty tool to test I3C target tty device.
diff --git a/Documentation/driver-api/i3c/target/index.rst b/Documentation/driver-api/i3c/target/index.rst
new file mode 100644
index 0000000000000..56eabfae83aa4
--- /dev/null
+++ b/Documentation/driver-api/i3c/target/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+I3C Target Framework
+======================
+
+.. toctree::
+   :maxdepth: 2
+
+   i3c-target
+   i3c-target-cfs
+   i3c-tty-howto
+
-- 
2.34.1

