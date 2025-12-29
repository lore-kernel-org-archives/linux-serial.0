Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2843161BF;
	Mon, 29 Dec 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767014678; cv=none; b=IqIybO75wXN9GY4hpqbNhE801hHZtxXACCjhdlWv1kyc+9oj2+cf7UtOd2e/hloZ/qBj+/gYByLscy5vzBE67JkN/K8ti+RBlrzQeLf/XXkbZWDZEkqbgU6SEMRMMd5pOK6CSq05x6zYdZ5MOMS/5J/mKAHaOPJ22kksavmun0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767014678; c=relaxed/simple;
	bh=Eti9OD+iaXFZHvABZhXYA8IxrA241HcyalJWujGe0Oc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=sGRd2SqGE1Yhw0Em6SjW1zjq3rfWutFav3A+Qnx2csFhaFwvxtfQEYJg+zpTc/98a0DnGrsJIkwfnAneEM+BrjxouU2P92+JNpKukDiAtt5vK9/0NM0U6lseA/vJqfGGW7BGsI4VAtAqNZxYaUsrpuygx0PyjFlD82lemYUhaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XhlPr+Rl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XhlPr+Rl"
Received: from [192.168.0.110] (unknown [49.205.248.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7CB6521246CD;
	Mon, 29 Dec 2025 05:24:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7CB6521246CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767014676;
	bh=WTBZMPFma66XH+Tv66P7VImD7F9RFzMDO73bbZH+d1o=;
	h=Date:From:Subject:To:Cc:From;
	b=XhlPr+RldDTiOcPlEFzPKxhqSDJovliVbjN7hsxXfHKHFjp9+3dBT0mBWcKuFWgVS
	 7/d4x4vCyaaOxGyqh9WxrWZoih0vtlI+gocGjl3VVZ+WkjZsxMmC2UBNyevLCJs0CE
	 09zpm5UGBy1j8tjoJI6+ufuUXbYS4jyV7VwRo4jo=
Message-ID: <6cc90adc-17e6-417e-8b9c-3a1f7f3d4fcd@linux.microsoft.com>
Date: Mon, 29 Dec 2025 18:54:24 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
Subject: Need inputs on hard lockups with "cat large_file.txt" use-case on 6.6
 kernel
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 "Thomas Gleixner, Ingo Molnar" <mingo@kernel.org>,
 Nam Cao <namcao@linutronix.de>, Miaoqian Lin <linmq006@gmail.com>,
 Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
 Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
I am debugging a hard-lockup issue which is seen when I do "cat" of a 
large text file (~3 MB or more) on my arm64 machine, which is based on 
6.6.116 kernel version and is using pl011 driver for UART.

I came across NBCON framework which tries to deal with such problems, 
but it is available on later kernels, and it would not be easy for me to 
do kernel upgrade at this moment.

I wanted to reach out here for any inputs that would help me debug this 
issue further - whether such lockups are expected, any kernel parameter, 
or patch that could fix this, etc.

Thanks in advance.

More details below:


I tried below experiments, but nothing worked:
* changing interrupt affinity of UART irq to other CPUs or group of 
CPUs, since all the UART interrupts were landing on CPU0.
* finding kernel cmdline parameters that can be tweaked - didn't seem to 
be related to "cat largefile" usecase, but for controlling general 
logging from drivers.
* Adding touch_nmi_watchdog(), cpu_relax() in different paths in the driver.
* adding handle_sysrq('l') in hardlockup handler to get CPU call stacks, 
or enable hardlockup_all_cpu_backtrace, but did not get call stacks of 
stuck CPUs.


Kernel cmdline:

console=ttyAMA0 earlycon=pl011,mmio32,0xFF000000,115200n8 reboot=w 
ima_hash=sha384 systemd.show_status=false ovlboot.bootdevice=E-MMC 
root=/dev/ram rw sysctl.kernel.printk_ratelimit=30 
sysctl.kernel.printk_ratelimit_burst=75 ima_policy=critical_data 
rcupdate.rcu_expedited=1 systemd.gpt_auto=no systemd.ssh_auto=no fips=1 
SYSTEMD_DEFAULT_MOUNT_RATE_LIMIT_BURST=100 systemd.log_ratelimit_kmsg=0 
crashkernel=512M


root@localhost:~# cat /proc/sys/kernel/printk
2       1       1       2


DT:
        serial0: serial@f1920000 {
                 bootph-all;
                 compatible = "arm,pl011", "arm,primecell";
                 status = "disabled";   -> enabled later in board
                 reg = <0 0xf1920000 0 0x1000>;
                 interrupts = <0 25 4>;
                 reg-io-width = <4>;
                 clock-names = "uartclk", "apb_pclk";
                 current-speed = <115200>;
         };

Regards,
Naman

