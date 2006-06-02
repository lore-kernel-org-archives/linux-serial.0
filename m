From: Francois WELLENREITER <francois.wellenreiter@bull.net>
Subject: Re: IA64: Broken Serial Console
Date: Fri, 02 Jun 2006 13:59:51 +0200
Message-ID: <44802837.9090006@bull.net>
References: <44128F9D.7050402@sgi.com> <200603112017.k2BKHcg20412@unix-os.sc.intel.com> <20060310082445.GA18715@verge.net.au> <yq0irqm39r8.fsf@jaguar.mkp.net> <20060311034346.GI11359@verge.net.au> <44128F9D.7050402@sgi.com> <20060313040825.GA31703@verge.net.au> <20060602114805.GA1462@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20060602114805.GA1462@verge.net.au>
Sender: linux-ia64-owner@vger.kernel.org
Cc: linux-ia64@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


>I am boot using the following command line:
>
>  console=tty0 console=uart,io,0x2f8 console=ttyS0
>
>Althogh I'm pretty sure I really only need:
>
>  console=uart,io,0x2f8
>  
>

Have you tried the following parameters ?

console=uart,io,0x2f8,115200n8
