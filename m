From: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Subject: Re: [PATCH v2 0/6] serial: imx: handshaking fixes and improvments
Date: Mon, 11 Apr 2016 18:01:28 +0200
Message-ID: <20160411160128.GD26941@ibawizard.net>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
Reply-To: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-2?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Martin Fuzzey <mfuzzey@parkeon.com>, Baruch Siach <baruch@tkos.co.il>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2016-03-24 14:24:19]:

> Among others it made my i.MX25 stuck when the other side toggles DCD.
> The first 4 patches are fixes that I'd like to see in 4.6-rcX, the last t=
wo
> patches are merge window material.

Hi,

just FYI, my i.MX6 board has stopped booting over NFS on 4.6-rc1 and I've j=
ust
bisected it down to the commit "serial: imx: repair and complete handshakin=
g"
90ebc48386, it's leading to the following CPU stall:

[   72.084538] INFO: rcu_sched self-detected stall on CPU
[   72.089719]  0-...: (1 GPs behind) idle=3D9bd/2/0 softirq=3D97/100 fqs=
=3D5996
[   72.096425]   (t=3D6000 jiffies g=3D-239 c=3D-240 q=3D47)
[   72.101154] Task dump for CPU 0:
[   72.104389] swapper/0       R running      0     0      0 0x00000002
[   72.110778] Backtrace:
[   72.113276] [<8010a580>] (dump_backtrace) from [<8010a778>] (show_stack+=
0x18/0x1c)
[   72.120850]  r7:80a09bc0 r6:80a02458 r5:80a05c00 r4:00000000
[   72.126589] [<8010a760>] (show_stack) from [<80137ee0>] (sched_show_task=
+0xb8/0xd8)
[   72.134258] [<80137e28>] (sched_show_task) from [<80139780>] (dump_cpu_t=
ask+0x34/0x44)
[   72.142177]  r5:00000000 r4:00000000
[   72.145806] [<8013974c>] (dump_cpu_task) from [<80157de8>] (rcu_dump_cpu=
_stacks+0x7c/0xa0)
[   72.154072]  r5:00000000 r4:80a09bc0
[   72.157697] [<80157d6c>] (rcu_dump_cpu_stacks) from [<8015ae74>] (rcu_ch=
eck_callbacks+0x218/0x65c)
[   72.166661]  r9:80a024a0 r8:0000002f r7:80a09bc0 r6:80a02100 r5:ef1a61c0=
 r4:80a09bc0
[   72.174499] [<8015ac5c>] (rcu_check_callbacks) from [<8015d0d0>] (update=
_process_times+0x38/0x68)
[   72.183376]  r10:ffffffff r9:ef1a2b40 r8:80a2d567 r7:00000010 r6:c84d964=
3 r5:00000000
[   72.191283]  r4:80a05c00
[   72.193854] [<8015d098>] (update_process_times) from [<8016c6bc>] (tick_=
sched_handle+0x50/0x54)
[   72.202555]  r5:80a01e20 r4:ef1a2cb8
[   72.206177] [<8016c66c>] (tick_sched_handle) from [<8016c70c>] (tick_sch=
ed_timer+0x4c/0x8c)
[   72.214546] [<8016c6c0>] (tick_sched_timer) from [<8015da94>] (__hrtimer=
_run_queues+0xd0/0x17c)
[   72.223247]  r7:00000001 r6:ef1a2b4c r5:ef1a2cb8 r4:ef1a2b00
[   72.228979] [<8015d9c4>] (__hrtimer_run_queues) from [<8015e074>] (hrtim=
er_interrupt+0xb8/0x208)
[   72.237768]  r10:ffffffff r9:7fffffff r8:00000003 r7:6e858000 r6:80a01d4=
8 r5:8094ab00
[   72.237768]  r10:ffffffff r9:7fffffff r8:00000003 r7:6e858000 r6:80a01d4=
8 r5:8094ab00
[   72.245674]  r4:ef1a2b00
[   72.248240] [<8015dfbc>] (hrtimer_interrupt) from [<8010dadc>] (twd_hand=
ler+0x34/0x40)
[   72.256159]  r10:80a01e70 r9:8093da28 r8:00000010 r7:eec1cc40 r6:80a026d=
c r5:eec03c00
[   72.264067]  r4:00000001
[   72.266629] [<8010daa8>] (twd_handler) from [<80152ef4>] (handle_percpu_=
devid_irq+0x70/0x8c)
[   72.275069]  r5:eec03c00 r4:ef1a8840
[   72.278695] [<80152e84>] (handle_percpu_devid_irq) from [<8014ec68>] (ge=
neric_handle_irq+0x20/0x30)
[   72.287744]  r9:8093da28 r8:eec05000 r7:00000010 r6:8094b044 r5:80a01f28=
 r4:00000000
[   72.295579] [<8014ec48>] (generic_handle_irq) from [<8014ef80>] (__handl=
e_domain_irq+0x94/0xbc)
[   72.304292] [<8014eeec>] (__handle_domain_irq) from [<80101408>] (gic_ha=
ndle_irq+0x58/0x98)
[   72.312646]  r9:8093da28 r8:f4001100 r7:80a11c50 r6:80a01e20 r5:80a026dc=
 r4:f4000100
[   72.320482] [<801013b0>] (gic_handle_irq) from [<8010b214>] (__irq_svc+0=
x54/0x70)
[   72.327971] Exception stack(0x80a01e20 to 0x80a01e68)
[   72.333036] 1e20: 00000000 00200000 00000000 00000000 80a00000 00000000 =
00000282 80a2e100
[   72.341227] 1e40: eec05000 8093da28 80a01e70 80a01ec4 80a01ec8 80a01e70 =
8011a2bc 80119ea0
[   72.349409] 1e60: 60000113 ffffffff
[   72.352902]  r9:8093da28 r8:eec05000 r7:80a01e54 r6:ffffffff r5:60000113=
 r4:80119ea0
[   72.360748] [<80119e2c>] (__do_softirq) from [<8011a2bc>] (irq_exit+0x8c=
/0xfc)
[   72.367974]  r10:00000000 r9:8093da28 r8:eec05000 r7:00000010 r6:8094b04=
4 r5:00000000
[   72.375880]  r4:00000000
[   72.378446] [<8011a230>] (irq_exit) from [<8014ef84>] (__handle_domain_i=
rq+0x98/0xbc)
[   72.386290] [<8014eeec>] (__handle_domain_irq) from [<80101408>] (gic_ha=
ndle_irq+0x58/0x98)
[   72.394644]  r9:8093da28 r8:f4001100 r7:80a11c50 r6:80a01f28 r5:80a026dc=
 r4:f4000100
[   72.402476] [<801013b0>] (gic_handle_irq) from [<8010b214>] (__irq_svc+0=
x54/0x70)
[   72.409964] Exception stack(0x80a01f28 to 0x80a01f70)
[   72.415027] 1f20:                   00000000 000012ce ef1a227c 80112b00 =
80a00000 80a02430
[   72.423215] 1f40: 80a02430 80a02380 efffc840 8093da28 00000000 80a01f84 =
80a01f88 80a01f78
[   72.431400] 1f60: 801079a4 801079a8 60000013 ffffffff
[   72.436455]  r9:8093da28 r8:efffc840 r7:80a01f5c r6:ffffffff r5:60000013=
 r4:801079a8
[   72.444289] [<80107974>] (arch_cpu_idle) from [<80148174>] (default_idle=
_call+0x30/0x34)
[   72.452395] [<80148144>] (default_idle_call) from [<8014826c>] (cpu_star=
tup_entry+0xf4/0x15c)
[   72.460936] [<80148178>] (cpu_startup_entry) from [<806294a0>] (rest_ini=
t+0x68/0x80)
[   72.468699] [<80629438>] (rest_init) from [<80900c74>] (start_kernel+0x2=
fc/0x368)
[   72.476193] [<80900978>] (start_kernel) from [<1000807c>] (0x1000807c)
[   72.482724]  r9:412fc09a r8:1000406a r7:80a06c7c r6:8093da24 r5:80a023dc=
 r4:80a2da14

To fix this problem, I've to revert the 90ebc48386 commit or apply this pat=
ch series.

-- ynezz
