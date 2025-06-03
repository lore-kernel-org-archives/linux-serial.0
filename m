Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19011033.outbound.protection.outlook.com [52.103.14.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3BE4C92;
	Tue,  3 Jun 2025 03:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748920708; cv=fail; b=oph475CAdtjpDHsG99vbopomGFgrqn15RpI+X09lI5E1dhZDneka/NBiRN/3lr5N1uc0viSFRv6Ds14ygYQjduWMBSZvyGMasfsuEZESZtKAPcy3XvKAV8EiXgxgcV2X2Wb1IA7l/TrkILBxJ31y7cHV01uWbqqeh2Ol5XztrJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748920708; c=relaxed/simple;
	bh=6Wf/egvnWWp/yDOyr+3/5DqPzvzONBKKe9Q1OHSuijo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ms3NqtoRvciR3N+vgdLWfQpQB7p0vKNCzE6RrCAdTlzDHBLD4R5EJBH6vKlJ6rup3UvSJxdiwHB/MC3CGarwz7kv2oRkTYM+ddSTsI0yvZLVSzuQI4HhqnrP0B9DK2yl3hyke49AuYhWD4/q5PKXLNvd4MPIQbRzRKDqp05xgh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mkt4Cekp; arc=fail smtp.client-ip=52.103.14.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mkt4Cekp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zk4fdBYSNd+qjg78txnuIVeADurdDb6sWL1sEBe2FTkRh7mLphcvMhyGgWIJIet2X00LvqJzewXu9r17SW/dPPSpUPM/SXTvj/ibrzGZTactMatlfi55hfpAz/gc7cCKqzHve6mWck3Zruv1MKOygmZoXXwk1FHPfUBcnajobu/4yOma3EWoq5ad9GTv17v1xHZGpMmRFs6pvwNlhcWg/Og0k+nbiVFLbWAUCFbhMu8FgMogvVGc1L2z+t55osmdA0oPPphAXNWI9zcjIV7ELiM6h0sXag+duUjIE2pHzJeK3JlnTRDXcMH1YOkw/pZ4+5Jl6NGqX6EG7HN7GBu1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3gT9sDvvs1Okl0MK7pqAvNpdu+73lof8osC/vlrEOo=;
 b=imzyiKhGJDOCn+ZPi8APSk1sBD477cPS2nwzCOageLi+5r9MrYefwkLRoLoPmMa/ADpiA5txBqPo71VUUaiGqQbeVT9457vTAldIOGNfs2LUX07gpzJNIMhzyPkhEhth2ZtNk6BQR8HcRq9nkMsLzbjkitKgTViuOJqkthlPagh52V+kKqSETWROesez2U2z9sKCWi5dlP7ZNR9Z3Bt3HRNTC5b1iAMrQ85NRgsp4wVKjSySyl67iCrx4lVePSF51R6buQybuF8i2eyKrMpD0AiN3hgBMglhqC/scOKSrONzK5mxvQvC7MMEOsHbNzVoDqncZAmb4yeAuVES+NYMcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3gT9sDvvs1Okl0MK7pqAvNpdu+73lof8osC/vlrEOo=;
 b=mkt4CekpaciTkG5rO4KfIegi10WwCPLkIKto4yVwuMs6gw0AM8HgXs23N/IOcf3w0yMdeaK6hd3E6fw4apWIr9eGDqWxaqmR3GsxPDjrPBT7z5CmC24s1hzqScazMVuZYeA046Sju9Ze1PBwtFiSduC5Vz8bFLUNOWy7o+wohdyh9euh6Ezt/ZOzBgds+MAEHdFB7WtIf8wypIFQfsmixrUIpG3QksN9lMnHoM0+HoH8e5tQM66PrCoBgT7SiO4UfYZEIUgLnus0LM146SduMn6RQYFocIDy18gInXqZ/3KvY7RrJyqL/AN136ILWPEHrKSGzUh8a4DtUbRUbVg7bQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB8770.namprd02.prod.outlook.com (2603:10b6:303:141::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 3 Jun
 2025 03:18:23 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8813.016; Tue, 3 Jun 2025
 03:18:23 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>, Russell King
	<linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "fj6611ie@aa.jp.fujitsu.com"
	<fj6611ie@aa.jp.fujitsu.com>
Subject: Problem with nbcon console and amba-pl011 serial port
Thread-Topic: Problem with nbcon console and amba-pl011 serial port
Thread-Index: AdvULbS8DdGjT9TLS9OOSVhbv2AtDg==
Date: Tue, 3 Jun 2025 03:18:23 +0000
Message-ID:
 <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB8770:EE_
x-ms-office365-filtering-correlation-id: d3dc964e-f50d-445d-9a69-08dda24d4c60
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799009|19110799006|8062599006|15080799009|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nRV6KEw0wlO9nk7X4x0qXyip68go7MMH4IpNpEHKf4mdNKG1U+KsrqKZzJON?=
 =?us-ascii?Q?hxBfIXtgwYFn2K12SLAcSaoVYThmY88NkbjbVUOrl8a1fpW0Pw0XXuUtBH3k?=
 =?us-ascii?Q?h0DTpvF8XQ0tZBrnzhPlEmdqhqcf3MXsNwcQE0aZfCp04bkGJHNDmsXlWipg?=
 =?us-ascii?Q?2YcYEHyI5i01QYycK49PGGMiM0OsWJgI9KilqFz+uF0rQVIsCOr4MpQ+rURS?=
 =?us-ascii?Q?KabCUW6/7Oa/CrAe1G+p5Mjtj8u91amusieYdFCS6PR9hnLDdFSmqBLJshoe?=
 =?us-ascii?Q?mRSdtxvkoK9qHsaSYD42UqjgNuFO76eCTwCBjrlIFpTJKMbcArlipzlwcUU5?=
 =?us-ascii?Q?xmG2wBmFzuiyTKRyoGo1IPgmvzFS4I+XQmCKkPjdzHH+c0/6JE1JChCOmCWm?=
 =?us-ascii?Q?9KeEpZyN5i3O0rPfT8Y3vKwjezMmugYI6KnxeiBjsoyiYl7TsMXl97cuWIPo?=
 =?us-ascii?Q?dWjcReJKdft8pA02izOS7snr1LfE+cxeS29hTcRf9/EzLcGKFyrZ61sOdXDv?=
 =?us-ascii?Q?EOx2Vb1IiJR58QretIt5H3S13Rt1fjEt5+wlikvFTEDNO/VAta5768RBEUcb?=
 =?us-ascii?Q?EmQulGWRd3JdyD+DqK/rSfWMkE+4PbApvDbmCLhBxoi1OcqSqzNNzqawmPpN?=
 =?us-ascii?Q?L6843g1KtO+h37T38UDNK6RnF38blNcBEBgNJCkKzTm7R9CTJZLC/29bSm4V?=
 =?us-ascii?Q?pXj1uzU1CbY/wcJ7NGggDt1KWOjSAY9WuVuA29UvWGP0abC5PesK8tCQKei9?=
 =?us-ascii?Q?JaP8RnaooaNHcNNB9PSrlOT+7WjL3+39Y6CKZWViQpxQbh8mXscCKRay1Krg?=
 =?us-ascii?Q?OwPMmmlyVnanTUlz6U4D4ttkH7mWEbD8ZDLyaN2Z8D8Ibl4IFpysTxv1/obq?=
 =?us-ascii?Q?fvVA8FoY6S0uIxQwy9BC4wbZZM65//rHc9p8jsWBNdAX01UuaFPSaogdBtBr?=
 =?us-ascii?Q?dejbed27nqCIXF9P8JngQJWMLcqrEgSuppiFbRw+Ifj8gYtTQz8sOLTkDuMr?=
 =?us-ascii?Q?Kv08vyBuwhTPYgNKaakjE4vXgY/Iogzx2J/s7s8/MZJpsLamH6Fg7qHbcDSC?=
 =?us-ascii?Q?lKEa/jMy1V2JR6V0b+xrivxn7DqkUA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1RkYlwI94KiaPgJUFVDic+nGLZhlcnSjT1zfnBPFMjgLfeJ5z8ndhifGbl2s?=
 =?us-ascii?Q?8TkHSE+VLbsfb+PRTaGG6Q14VfcnJcuSAfkyorWOKnHv8vZ5LglJCLWxp52e?=
 =?us-ascii?Q?8j7aANJvEUTfIjxL3rZ4Ss9G8hdyqOqbnNkhBXrY6bKk7PzkrJw+1f+eBTEr?=
 =?us-ascii?Q?K/WaShllQCarSPbMDCen1BBXHi5TtmsWKNVl4PhudQSwT9Ono0CGYTjC2bMq?=
 =?us-ascii?Q?sxyaf56bL7mBfBh/UnJQwUDOAdt0dUkTi1hgav39Hlq/37O7RL/hjrvbxiwK?=
 =?us-ascii?Q?MRmDrAnlyQcTM/VUCfXnV2M+xFftlxAH4nriyXv+mb+DQuZQM+lxNcMdN41f?=
 =?us-ascii?Q?Ys2IlIvfgGQ0orKptKtvLhPz0HkkwWoklHw9Rzu84kaXt+ras7TFlH0ML1Xm?=
 =?us-ascii?Q?xuh+YciUo3XyfjJqipMeDnt7nOhk8EvokvJJvDXn2EhZc1FgLVWdzejgrJNo?=
 =?us-ascii?Q?BcvRo6IVKCyFBVOCuyCXFBAawcPiOAOjpuD55ERRvXgeoA+ytOLaIU/MH2kT?=
 =?us-ascii?Q?2At6uxA2MWxarGEby7mFj1WDhZ+ImMOTjR4+2YOMcGk0eIEcAXc8+hwo8H5N?=
 =?us-ascii?Q?D1EXHj0HpTHueSdG0ai80+p6h++f1kH+sSeb3+y54eVItI8AKxlDN7UaanID?=
 =?us-ascii?Q?tZ+grpbQCJafyDrXXSAOvOBP1rbyGMcCvcY3QuwR0oc3qM+PYB+tBPC1YlI+?=
 =?us-ascii?Q?PKLBsPn8WutXuc7oPHduCHp5A2TbmXk1AXk+r79uzrQH6JzoUnRhKxD4Bp20?=
 =?us-ascii?Q?PHEBzgoXJTiLA3wkJjz+JcpefeqAtRbeYKZLqpAZS3cmZf6L32DqKI2vY1/B?=
 =?us-ascii?Q?tUd0Nzv+vZFjzzziapppognLVl6D4bE/HrKNvF/TvTd+60vmWItNFsv9TVGF?=
 =?us-ascii?Q?I1/QjcnEG25lMRRyc9t1nV20ptyJiGOnvhvZFi7uuSKOJoe0DikbreO7wTAK?=
 =?us-ascii?Q?QsSz3eEW2cftb6e/kst6Ae3ceFRyIIzMI7lqUrXeIJvdb+NRrsEsRzdYrI2M?=
 =?us-ascii?Q?fzwt7E/sAI9+szeyaoGyqgNWsy+JbgYzGGF7ls5YSNKmil8WaN81tVh2VEu8?=
 =?us-ascii?Q?TliodcTmJ1GsPd61fz1FAa4hXtafH7DHEMHVAW8hFqDC8IBmgGd2JV+Ua0xO?=
 =?us-ascii?Q?ZII/RSIn9ESjf+rk7KbCPEcw/dgIGj7VSR7CjTonIVq0VH0YuNsuMmGQQur7?=
 =?us-ascii?Q?0LslHJGZIrTCu0RscFNLS3QLsz4nqGfRKk9QxL9giW6bsCMn5KpE1k6mLgg?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dc964e-f50d-445d-9a69-08dda24d4c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 03:18:23.3598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8770

I'm seeing a problem in the panic path of an ARM64 VM on Hyper-V
in the Azure public cloud.  Here's the output from the VM's serial port:

# taskset -c 4 /bin/echo c >/proc/sysrq-trigger

[
** replaying previous printk message **
[   51.616656] sysrq: Trigger a crash
[   51.616689] Kernel panic - not syncing: sysrq triggered crash
[   51.624212] CPU: 4 UID: 0 PID: 2278 Comm: echo Tainted: G            E  =
     6.15.0-rc7-next-20250521 #1 VOLUNTARY=20
[   51.630165] Tainted: [E]=3DUNSIGNED_MODULE
[   51.632331] Hardware name: Microsoft Corporation Virtual Machine/Virtual=
 Machine, BIOS Hyper-V UEFI Release v4.1 09/28/2024
[   51.638771] Call trace:
[   51.640179]  show_stack+0x20/0x38 (C)
[   51.642488]  dump_stack_lvl+0xc8/0xf8
[   51.644638]  dump_stack+0x18/0x28
[   51.646654]  panic+0x384/0x478
[   51.648371]  sysrq_handle_crash+0x20/0x28
[   51.650815]  __handle_sysrq+0xdc/0x2b8
[   51.653080]  write_sysrq_trigger+0x124/0x240
[   51.655508]  proc_reg_write+0xa4/0x100
[   51.657917]  vfs_write+0xd8/0x3e0
[   51.659836]  ksys_write+0x74/0x110
[   51.661735]  __arm64_sys_write+0x24/0x38
[   51.663967]  invoke_syscall+0x6c/0xf8
[   51.666025]  el0_svc_common.constprop.0+0xc8/0xf0
[   51.668771]  do_el0_svc+0x24/0x38
[   51.670713]  el0_svc+0x40/0x198
[   51.672509]  el0t_64_sync_handler+0xc8/0xd0
[   51.675170]  el0t_64_sync+0x1b0/0x1b8
[   51.677351] SMP: stopping secondary CPUs
[   52.728175] SMP: failed to stop secondary CPUs 2
[   52.731229] Kernel Offset: 0x5706ebce0000 from 0xffff800080000000
[   52.734528] PHYS_OFFSET: 0x0
[   52.736115] CPU features: 0x2000,400007c0,02110ca1,5401faab
[   52.739275] Memory Limit: none
[   52.803615] ---[ end Kernel panic - not syncing: sysrq triggered crash ]=
---

The problem is the failure to stop secondary CPU 2.  (The CPU # that fails
to stop varies from run-to-run.) It is mostly reproducible, but not always.=
 I
bisected to commit 2eb2608618ce ("serial: amba-pl011: Implement nbcon
console") in the 6.15 kernel. Further custom logging shows the details of
why the problem can happen. Here are the steps:

1. The "echo" command ends up in __handle_sysrq(), which outputs the
"sysrq: Trigger a crash" message using pr_info().  I always ran the "echo"
command on CPU 4 just for consistency in my testing/debugging -- there's
nothing special about CPU 4.

2. The "pr/ttyAMA0" kernel thread handles the outputting of the message.
nbcon_kthread_func() calls nbcon_emit_one() with the "use_atomic" parameter
set to false. nbcon_emit_one() in turn calls nbcon_emit_next_record() with
the console spin lock held and interrupts disabled. nbcon_emit_next_record(=
)
then calls pl011_console_write_thread(). The latter has a "for" loop to out=
put
each character of the message, and my custom logging shows that it is indee=
d
outputting the string "[   51.616656] sysrq: Trigger a crash".

3. While "pr/ttyAMA0" is doing its thing, __handle_sysrq() calls
sysrq_handle_crash(), which calls panic(). After some preliminaries, panic(=
)
outputs the message "Kernel panic - not syncing: sysrq triggered crash"
using pr_emerg().

4. pr_emerg() has a high logging level, and it effectively steals the conso=
le
from the "pr/ttyAMA0" task, which I believe is intentional in the nbcon des=
ign.
Down in pl011_console_write_thread(), the "pr/ttyAMA0" task is doing
nbcon_enter_unsafe() and nbcon_exit_unsafe() around each character
that it outputs.  When pr_emerg() steals the console, nbcon_exit_unsafe()
returns 0, so the "for" loop exits. pl011_console_write_thread() then
enters a busy "while" loop waiting to reclaim the console. It's doing this
busy "while" loop with interrupts disabled, and because of the panic,
it never succeeds. Whatever CPU is running "pr/ttyAMA0" is effectively
stuck at this point.

5. Meanwhile panic() continues, calling panic_other_cpus_shutdown(). On
ARM64, other CPUs are stopped by sending them an IPI. Each CPU receives
the IPI and calls the PSCI function to stop itself. But the CPU running
"pr/ttyAMA0" is looping forever with interrupts disabled, so it never
processes the IPI and it never stops. ARM64 doesn't have a true NMI that
can override the looping with interrupts disabled, so there's no way to
stop that CPU.

6. The failure to stop the "pr/ttyAMA0" CPU then causes downstream
problems, such as when loading and running a kdump kernel.

The problem is timing dependent.  In some cases, the "pr/ttyAMA0"
thread is evidently able to get the message out before panic() calls
pr_emerg(). In my case running as a guest on Hyper-V, the pl011 device
in the guest VM is emulated by Hyper-V. Each pl011 register access
traps to the hypervisor, which slows things down and probably makes
the problem more likely. But from what I can see, the underlying
race condition exists regardless.

At this point, I just wanted to surface the problem. I don't have any
specific ideas on how to fix it, as my knowledge of nbcon is limited
to what I've learned in figuring out the failure path.

Toshiyuki -- what are your thoughts how to fix this?

Michael Kelley
