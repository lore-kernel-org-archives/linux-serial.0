From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v3 0/2] tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
Date: Thu, 11 Apr 2019 16:45:24 +0200
Message-ID: <mvm1s28fvnf.fsf@suse.de>
References: <20181020101045.15991-1-paul.walmsley@sifive.com>
        <mvmr2bkxntv.fsf@suse.de>
        <alpine.DEB.2.21.9999.1904110151030.5868@viisi.sifive.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.9999.1904110151030.5868@viisi.sifive.com> (Paul
        Walmsley's message of "Thu, 11 Apr 2019 01:54:05 -0700 (PDT)")
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Wesley Terpstra <wesley@sifive.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Apr 11 2019, Paul Walmsley <paul.walmsley@sifive.com> wrote:

> On Wed, 6 Mar 2019, Andreas Schwab wrote:
>
>> Trying to log in on the serial console causes the system to freeze.  The
>> last message is:
>> 
>> [  115.597858] sifive-serial 10010000.serial: BRKINT/PARMRK flag not supported
>
> Have not seen that problem.

# stty sane -F /dev/ttySIF0
<crash>

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
