From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] tty/serial: Skip 'NULL' char after console break when
 sysrq enabled
Date: Thu, 24 Dec 2015 11:43:46 -0500 (EST)
Message-ID: <20151224.114346.690529944368284120.davem@davemloft.net>
References: <1450896933-192269-1-git-send-email-vijay.ac.kumar@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450896933-192269-1-git-send-email-vijay.ac.kumar@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vijay.ac.kumar@oracle.com
Cc: gregkh@linuxfoundation.org, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, karl.volz@oracle.com
List-Id: linux-serial@vger.kernel.org

From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Wed, 23 Dec 2015 10:55:33 -0800

> When sysrq is triggered from console, serial driver for SUN hypervisor
> console receives a console break and enables the sysrq. It expects a valid
> sysrq char following with break. Meanwhile if driver receives 'NULL'
> ASCII char then it disables sysrq and sysrq handler will never be invoked.
> 
> This fix skips calling uart sysrq handler when 'NULL' is received while
> sysrq is enabled.
> 
> Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
> Acked-by: Karl Volz <karl.volz@oracle.com>

Applied, thank you.
