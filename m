Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEDE1D5CFE;
	Tue, 30 Dec 2025 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767085472; cv=none; b=LvGqw91N4JdWGOv0psJjQF9RIWjdpfI5cATp7c5gPBgcpITjKOnAosP/NWVV+5PIvK2bylH5A3TUWML2F97osA+mvqDaJ2WftV1+aZP3HTkel1iN3JMLebIYlIAPzHGKCWtWxDYVUD20nNl5NjtpXCRTBgccoyzLEatQs1u0Al4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767085472; c=relaxed/simple;
	bh=pdxdWa6WVw33k4UlcPfSjdRPojsYAkEEKnpWreR3InU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NRewOCiusRTAcwPepnAeChAr6cFeBLzvRE4lInco4as8UZeXzWf3cbSrfQYIusmqRfalCQDrO16yxmNwSBJojReeQQ9aAftz2qYSX4UC2fqym1HJD8XSg9SEUG8nRjz1XlQRVLmw3Ziw9DgJDccMndp5alwwnIlpje/FBxJe+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f7vJ1V16; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f7vJ1V16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Cv
	JbhmQQpGmZOmORvAU+jWAcx9MsYFyU0MFCx7ZtUA0=; b=f7vJ1V162tKogH8iZK
	XbvWvRgyqywDLaGC7BzxXeIUYeSk4NJWSsvTeoZurDnwMOjiv50h2A/Mf2g/YGS+
	93b7cJnSpIdtkXQb+Jh6vNNQ+RcCgfSja3VZDSCaGBCHDI9UOzFs32vxmStPaq5a
	9qWn87EGJQeRpQYBQveY4AESc=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wBnEY1tlVNpn30rDA--.1000S2;
	Tue, 30 Dec 2025 17:03:43 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: jackzxcui1989@163.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	tj@kernel.org,
	hch@infradead.org
Subject: Re: [PATCH v8] tty: tty_port: add workqueue to flip TTY buffer
Date: Tue, 30 Dec 2025 17:03:41 +0800
Message-Id: <20251230090341.853655-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251223034836.2625547-1-jackzxcui1989@163.com>
References: <20251223034836.2625547-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnEY1tlVNpn30rDA--.1000S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW7GFW8XF4UuF18tw4UCFg_yoWDWrXE9r
	WDtws8Kw4IvrnxG3Wjyr4FvFWfZrZ0kw40gFs3WFWDC34Sq3yfCFZavr43Cw1fWFW5tFsr
	JrnIqw4xZ3ZFkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREJKItUUUUU==
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC5w+vuWlTlW8G7AAA3U

Hi all,

On Tue, 23 Dec 2025 11:48:36 +0800 Xin Zhao <jackzxcui1989@163.com> wrote:
> On the embedded platform, certain critical data, such as IMU data, is
> transmitted through UART. The tty_flip_buffer_push() interface in the TTY
> layer uses system_dfl_wq to handle the flipping of the TTY buffer.
> Although the unbound workqueue can create new threads on demand and wake
> up the kworker thread on an idle CPU, it may be preempted by real-time
> tasks or other high-prio tasks.
> 
> flush_to_ldisc() needs to wake up the relevant data handle thread. When
> executing __wake_up_common_lock(), it calls spin_lock_irqsave(), which
> does not disable preemption but disables migration in RT-Linux. This
> prevents the kworker thread from being migrated to other cores by CPU's
> balancing logic, resulting in long delays. The call trace is as follows:
> 
> ...


Are there any other changes needed before the patch is merged?

Jiri has reviewed the patch, and I have made the modifications. :)

--
Xin Zhao

