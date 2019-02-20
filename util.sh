work_dir=`pwd`
bin_vec=(``)
bin_vec[0]="stop"
stop() {
    echo "stop"
    openresty -p ${work_dir} -s stop
}
bin_vec[1]="start"
start() {
    echo "start"
    openresty -p ${work_dir} -c ${work_dir}/conf/nginx.conf
    sleep 1
    pid=`ps -ef | grep "openresty" | grep -v "grep" | awk '{print $2}'`
    echo $pid > pid
}
bin_vec[2]="info"
info() {
    echo "info"
    netstat -nlt | grep 8080
    lsof -i tcp:8080
}
bin_vec[3]="restart"
restart() {
    echo "restart"
    openresty -p ${work_dir} -s stop
    openresty -p ${work_dir} -c ${work_dir}/conf/nginx.conf
    sleep 1
    pid=`ps -ef | grep "openresty" | grep -v "grep" | awk '{print $2}'`
    echo $pid > pid

}
bin_name=$1
help=1
for((i=0;i<${#bin_vec[*]};i++))
do
    if [ "${bin_vec[$i]}" = "$bin_name" ];then
        shift 1
        help=0
        ${bin_vec[$i]}
    fi
done

if [ $help -eq 1 ];then
    echo "opt is :"
    for((i=0;i<${#bin_vec[*]};i++))
    do
        echo "[${bin_vec[$i]}]"
    done
fi
