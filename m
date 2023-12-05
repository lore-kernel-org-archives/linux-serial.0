Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4A5B4;
	Mon,  4 Dec 2023 17:56:22 -0800 (PST)
X-QQ-mid: bizesmtp70t1701741346t4l4l7yb
Received: from localhost ( [183.209.108.253])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 05 Dec 2023 09:55:44 +0800 (CST)
X-QQ-SSF: 01400000000000502000000A0000000
X-QQ-FEAT: +HVWQWZs/U1rVd5+QmdHvPd1RbBzPQJKXsHksnFQdEO7qWh1a8bIVQRi8F/sH
	afiR/c6hjfa1I4t2/UVklocC0tXmxjHTYIS9u0IaWUw/78UwlCn4lCQEMDpdNSBOkqHvzvu
	HgCooHeVfPst/GIDIktWB+oEsqbdSOdR1J+0lWX9GeATIWYOsQxvGRADcc279TZGkTW2eIT
	SysL0I1C1Pv8J4EtScOtD9msqdyrr+k2o7BDbbuOOy0wG8Rfmq0uZKQzv71Lf7YBoxopltk
	loeKeF/51c2gCJ5PkVahvA1TuO6QmyoeIAEpSbW+z+4LIe5m0vhjqjHjPdbmAbvVHRQcIBI
	SdyJceXOVDj+D5RNxQJ3lqadznptdw59W12Gb+ss4m4qlLN+gdzs28b4tGFZw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15755231320433249742
Date: Tue, 5 Dec 2023 09:55:44 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilpo =?utf-8?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, jszhang@kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>, set_pte_at@outlook.com,
	stable@kernel.org
Subject: Re: [PATCH] serial: dw8250: Make DLF feature independent of
 ADDITIONAL_FEATURE
Message-ID: <6863B74199951BD2+ZW6DIO1n0phYBjg9@centos8>
References: <20231204130820.2823688-1-dawei.li@shingroup.cn>
 <48f6fcce-4b5-a7c0-2fc0-989b9a2fba8@linux.intel.com>
 <ZW3UP8hfI7_-TsVl@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZW3UP8hfI7_-TsVl@smile.fi.intel.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Ilpo, Andy,

On Mon, Dec 04, 2023 at 03:29:35PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 04, 2023 at 03:20:09PM +0200, Ilpo Järvinen wrote:
> > On Mon, 4 Dec 2023, Dawei Li wrote:
> > 
> > > DW apb uart databook defines couples of configuration parameters of
> 
> DW_apb_uart (as it's part of file name, or spell this fully).
> 
> > > dw8250 IP, among which there are 2 of them:
> 
> DesignWare 8250 IP
> 
> ..
> 
> > > The bug was hit when we are bringing up dw8250 IP on our hardware
> 
> Ditto.
> 
> > > platform, in which parameters are configured in such combination:
> > > - ADDTIONAL_FEATURE disabled;
> > > - FRACTIONAL_BAUD_DIVISOR_EN enabled;
> 
> ..
> 
> > The very same code change is already in tty-next (from another author).
> 
> For your convenience:
> 
> d804987153e7 ("serial: 8250_dw: Decouple DLF register check from UCV")

[sigh]

Apparently I thought tty/for-linus is the "bug fixing" branch for tty by
mistake, and didn't realize the same fix patch has been landed in tty-next
for a while.

Thanks for the update.

Anyway, I believe the fixing patch should cc stable and be getting backported?
I hit the bug on 5.10.x, it's possible the bug has been there before that.

Thanks,
   dawei

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 
