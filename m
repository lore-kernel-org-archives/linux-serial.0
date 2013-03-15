From: Shuge <shugelinux@gmail.com>
Subject: Re: [BUG]: when printk too more through serial, cpu up is failed.
Date: Fri, 15 Mar 2013 09:26:26 +0800
Message-ID: <514278C2.3020900@gmail.com>
References: <5141D5E6.4060001@gmail.com> <20130314140553.GA4895@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:41701 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab3COBeO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 14 Mar 2013 21:34:14 -0400
In-Reply-To: <20130314140553.GA4895@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Kevin <kevin@allwinnertech.com>, linux-serial@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Tejun Heo <tj@kernel.org>

=E4=BA=8E 2013=E5=B9=B403=E6=9C=8814=E6=97=A5 22:05, Greg KH =E5=86=99=E9=
=81=93:
> On Thu, Mar 14, 2013 at 09:51:34PM +0800, Shuge wrote:
>> Hi all,
>>      When the kernel printk too many log, the cpu is failed to come =
online.
>> The problem is this:
>> For example, cpu0 bring up cpu1:
>>
>>        a. cpu0 call cpu_up:
>>           cpu_up()
>>           ->_cpu_up()
>>              ->__cpu_notify(CPU_UP_PREPARE)
>>              ->__cpu_up()
>>                 ->boot_secondary()
>> #       ->wait_for_completion_timeout(&cpu_running, msecs_to_jiffire=
s(1000))
>>           -> if (!cpu_online(cpu)) {
>>                    pr_crit("CPU%u: failed to come online\n", cpu);
>>                    ret =3D -EIO;
>>                }
>>           ->cpu_notify(CPU_ONLINE)
>>
>>        b. cpu1 enter kernel:
>>        secondary_start_kernel()
>> @   ->printk("CPU%u: Booted secondary processor\n", cpu)
>> *   ->calibrate_delay()
>>        ->set_cpu_online()
>>        ->complete(cpu_running)
>>          ->cpumask_set_cpu()
>>
>>     While cpu0 run to mark #,  which wait that cpu1 complete
>> cpu_running, and set online.
>> Generally, cpu0 can get it. But if the __log_buf is too large or
>> other threads write
>> it unceasing, then cpu1 come to mark @ or * in this moment. Cpu1 is
>> busy outputing
>> buffer, which cost time more than 1s, and cpu1 have not join in
>> sched, so cpu0 wait it timeout.
>>     By reading printk.c, I found that can_use_console() always retur=
n
>> true, which be called by
>> console_trylock_for_printk(). Because, have_callable_console()
>> return ture always, if the console
>> driver set CON_ANYTIME flag. I think that cpu should not output the
>> __log_buf in coming online,
>> even though have_callable_console() is true.
>>
>> /*
>>   * Can we actually use the console at this time on this cpu?
>>   *
>>   * Console drivers may assume that per-cpu resources have
>>   * been allocated. So unless they're explicitly marked as
>>   * being able to cope (CON_ANYTIME) don't call them until
>>   * this CPU is officially up.
>>   */
>> static inline int can_use_console(unsigned int cpu)
>> {
>>      return cpu_online(cpu) || have_callable_console();
>> }
>>
>> In can_use_console, why not is &&, but ||?
>>
>> Kernel Version: 3.3.0
> Why such an old and obsolete kernel version?  Please try this on 3.8,
> lots of work have gone into the printk area that should have solved t=
his
> issue.
>
> greg k-h

I saw the printk.c in version 3.9, it still check=20
console_trylock_for_printk() to decide to call console_unlock. In=20
vprintk_emit(), cpu1 also have the opportunity to execute=20
console_unlock() at coming online time.
Once cpu which is coming online can output buffer, nothing can interrup=
t=20
it until buffer is empty.But we can't ensure that none always write the=
=20
__log_buf. It is danger! I think, the solution is that we should preven=
t=20
to use console at coming online.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
