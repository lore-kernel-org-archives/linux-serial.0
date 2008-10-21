From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: Initialize spinlocks in 8250 and don't clobber
 them.
Date: Tue, 21 Oct 2008 16:50:18 +0100
Message-ID: <20081021165018.28794974@lxorguk.ukuu.org.uk>
References: <48F51114.2010105@caviumnetworks.com>
	<20081020141750.d0610586.akpm@linux-foundation.org>
	<20081021103833.5e960c8d@lxorguk.ukuu.org.uk>
	<48FDF6CB.4070605@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754218AbYJUPua@vger.kernel.org>
In-Reply-To: <48FDF6CB.4070605@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Tomaso.Paoletti@caviumnetworks.com
List-Id: linux-serial@vger.kernel.org

> The question is:  What is the best way to initialize some (or all) fields of a structure *except* a single lock field that was previously initialized?

Move the initialisation - or at least memset to zero then spin_lock_init
and fill in the other fields later.
